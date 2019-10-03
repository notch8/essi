# Generated via
#  `rails generate hyrax:work PagedResource`
module Hyrax
  # Generated controller for PagedResource
  class PagedResourcesController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include ESSI::WorksControllerBehavior
    include ESSI::PagedResourcesControllerBehavior
    include ESSI::RemoteMetadataLookupBehavior
    include Hyrax::BreadcrumbsForWorks
    include ESSI::BreadcrumbsForWorks
    self.curation_concern_type = ::PagedResource

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::PagedResourcePresenter

    def structure
      parent_presenter
      @members = presenter.member_presenters
      @logical_order = presenter.logical_order_object
    end

    def additional_response_formats(wants)
      wants.uv do
        presenter && parent_presenter
        render 'viewer_only.html.erb', layout: 'boilerplate', content_type: 'text/html'
      end
    end

    def save_structure
      structure = { "label": params["label"], "nodes": params["nodes"] }
      if curation_concern.lock?
        head 423
      else
        SaveStructureJob.perform_later(curation_concern, structure.to_json)
        head 200
      end
    end
  end
end
