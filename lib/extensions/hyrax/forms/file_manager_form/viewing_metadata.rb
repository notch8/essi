module Extensions
  module Hyrax
    module Forms
      module FileManagerForm
        module ViewingMetadata
          delegate :viewing_direction, :viewing_hint, to: :model
        end
      end
    end
  end 
end
