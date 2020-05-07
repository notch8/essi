# Generated via
#  `rails generate hyrax:work Image`
module Hyrax
  module Actors
    class ImageActor < Hyrax::Actors::BaseActor
      include FlexibleMetadata::DynamicActorBehavior
      include ESSI::ApplyOCR
    end
  end
end