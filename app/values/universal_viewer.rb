class UniversalViewer
  include Singleton
  include ActionView::Helpers::TagHelper
  class << self
    def script_tag
      @script_tag ||= instance.script_tag
    end
  end

  def script_tag
    content_tag(:script,
                '',
                type: 'text/javascript',
                id: 'embedUV',
                src: viewer_link)
  end

  def viewer_link
    safe_join([Rails.application.config.relative_url_root, viewer_root, \
               "uv-2.0.1", 'lib', 'embed.js'], '/')
  end

  def viewer_root
    'bower_includes/universalviewer/dist'
  end
end
