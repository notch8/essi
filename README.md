# ESS Images [![CircleCI](https://circleci.com/gh/IU-Libraries-Joint-Development/essi.svg?style=svg)](https://circleci.com/gh/IU-Libraries-Joint-Development/essi)

A Samvera Hyrax based image cataloging application.


To set up a development environment via Docker:

- Pull down the Github repo
- Run `docker-compose up web`
- Load the application at `localhost:3000` or `http://essi.docker` (1)


1) Requires [Dory](https://github.com/FreedomBen/dory)


# SPECS:
1. Jasmine - Can run from terminal or by adding /specs path onto the base url (ex: <http://localhost:3000/specs>).
2. RSPEC - May need to run `sc exec -s solr 'solr-precreate hydra-test /opt/config'`
