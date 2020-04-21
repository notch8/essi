# Generated via
#  `rails generate hyrax:work Image`
module Hyrax
  module Actors
    class ImageActor < Hyrax::Actors::BaseActor
      include FlexibleMetadata::DynamicActorBehavior
      include ESSI::ApplyOCR
      def create(env)
        add_dynamic_schema(env)
        super
      end
    end
  end
end