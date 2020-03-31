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
    include ESSI::StructureBehavior
    include Hyrax::BreadcrumbsForWorks
    include ESSI::BreadcrumbsForWorks
    self.curation_concern_type = ::PagedResource

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::PagedResourcePresenter

    def show
      super
      set_catalog_search_term_for_uv_search
    end

    def set_catalog_search_term_for_uv_search
      return unless request&.referer&.present? && request&.referer&.include?('catalog')
      url_args = request&.referer&.split('&')
      search_term = []
      url_args&.each do |arg|
        next unless arg.match?('q=')
        search_term << CGI::parse(arg)['q']
      end
      params[:highlight] = search_term&.flatten&.first
    end
  end
end
