# Generated via
#  `rails generate hyrax:work Scientific`
module Hyrax
  class ScientificPresenter < Hyrax::WorkShowPresenter
    include ESSI::PresentsNumPages
    include ESSI::PresentsOCR
    include ESSI::PresentsStructure
  end
end
