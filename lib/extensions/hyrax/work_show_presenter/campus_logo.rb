# Makes campus logo available to Collections, Works, and FileSets.
module Extensions
  module Hyrax
    module WorkShowPresenter
      module CampusLogo
        def campus_logo
          # Check if campus information is set for admin set
          set = admin_set.first.parameterize(separator: '_')
          return false unless ESSI.config[:essi][:campus_logos].present? && ESSI.config[:essi][:campus_logos][set]

          title = ESSI.config[:essi][:campus_logos][set][:title]
          link = ESSI.config[:essi][:campus_logos][set][:url]
          "<a href='#{link}'>#{title}</a>".html_safe
        end
      end
    end
  end
end
