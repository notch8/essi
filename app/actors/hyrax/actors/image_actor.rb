# Generated via
#  `rails generate hyrax:work Image`
module Hyrax
  module Actors
    class ImageActor < Hyrax::Actors::BaseActor
      # @todo - add to m3 generator
      # override (from Hyrax 2.5.0) - add the dynamic schema to new works
      def create(env)
        add_dynamic_schema(env)
        super
      end

      private

      # @todo - add to m3 generator
      # override (from Hyrax 2.5.0)
      # @param [Hyrax::Actors::Environment] env
      def add_dynamic_schema(env)
        env.curation_concern.dynamic_schema = env.curation_concern.base_dynamic_schema(
          env.attributes[:admin_set_id]
        )
      end
    end
  end
end
