class UniversityPlaceAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  def initialize(value, options = {})
    super(:university_place, value, options)
  end

  def value_html
    Array(values).map do |value|
      location_string(UniversityPlaceService.find(value))
    end.join("")
  end

  private

    def attribute_value_to_html(value)
      loc = UniversityPlaceService.find(value)
      li_value location_string(loc)
    end

   def location_string(loc)
     return unless loc
     content_tag(:a,
                 loc.dig(:label),
                 href: loc.dig(:url))
   end
end
