# Generated via
#  `rails generate hyrax:work BibRecord`
module Hyrax
  module Actors
    class BibRecordActor < Hyrax::Actors::BaseActor
      include ESSI::ApplyOCR
    end
  end
end
