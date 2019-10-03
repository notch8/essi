# system dependency image
FROM ruby:2.5-stretch AS essi-sys-deps

RUN apt-get update -qq && \
    apt-get -y install apt-transport-https && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get update -qq && \
    apt-get install -y build-essential default-jre-headless libpq-dev nodejs \
      libreoffice-writer libreoffice-impress imagemagick unzip ghostscript \
      tesseract-ocr \
      yarn && \
    rm -rf /var/lib/apt/lists/*
RUN yarn && \
    yarn config set no-progress && \
    yarn config set silent
RUN mkdir -p /opt/fits && \
    curl -fSL -o /opt/fits/fits-1.3.0.zip http://projects.iq.harvard.edu/files/fits/files/fits-1.3.0.zip && \
    cd /opt/fits && unzip fits-1.3.0.zip && chmod +X fits.sh
ENV PATH /opt/fits:$PATH

# ruby dev image
FROM essi-sys-deps AS essi-dev

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem update bundler
RUN bundle install -j 2 --retry=3

COPY . .
RUN mkdir -p /run/secrets
COPY config/essi_config.docker.yml /run/secrets/essi_config.yml

ENV RAILS_LOG_TO_STDOUT true

# ruby dependencies image
FROM essi-sys-deps AS essi-deps

RUN mkdir /app
WORKDIR /app

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

COPY Gemfile Gemfile.lock ./
RUN gem update bundler
RUN bundle install -j 2 --retry=3 --deployment --without development

COPY . .

ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_ENV production

ENTRYPOINT ["bundle", "exec"]

# sidekiq image
FROM essi-deps as essi-sidekiq
ARG SOURCE_COMMIT
ENV SOURCE_COMMIT $SOURCE_COMMIT
CMD sidekiq

# webserver image
FROM essi-deps as essi-web
RUN bundle exec rake assets:precompile
RUN yarn install
EXPOSE 3000
ARG SOURCE_COMMIT
ENV SOURCE_COMMIT $SOURCE_COMMIT
CMD puma -b tcp://0.0.0.0:3000
