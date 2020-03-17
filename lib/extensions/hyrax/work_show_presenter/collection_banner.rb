module Extensions
  module Hyrax
    module WorkShowPresenter
      module CollectionBanner
        def collection
          # return work collection if any, else nil
          return false if member_of_collection_ids.empty?

          Collection.find(member_of_collection_ids.first)
        end
      end
    end
  end
end
