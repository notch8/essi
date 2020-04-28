# Generated via
#  `rails generate hyrax:work Scientific`
module Hyrax
  module Actors
    class ScientificActor < Hyrax::Actors::BaseActor
      include FlexibleMetadata::DynamicActorBehavior
      include ESSI::ApplyOCR
      def create(env)
        add_dynamic_schema(env)
        super
      end
    end
  end
end
