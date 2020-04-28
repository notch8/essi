# Generated via
#  `rails generate hyrax:work PagedResource`
module Hyrax
  module Actors
    class PagedResourceActor < Hyrax::Actors::BaseActor
      include FlexibleMetadata::DynamicActorBehavior
      include ESSI::ApplyOCR
      def create(env)
        add_dynamic_schema(env)
        super
      end
    end
  end
end
