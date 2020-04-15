module ESSI
  module OCRSearch

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
