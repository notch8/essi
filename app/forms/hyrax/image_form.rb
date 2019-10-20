# Generated via
#  `rails generate hyrax:work Image`
module Hyrax
  # Generated form for Image
  class ImageForm < Hyrax::Forms::WorkForm
    self.model_class = ::Image
    self.terms += [:resource_type]
    self.required_fields -= [:keyword]
    # @todo - fix undefined method `primary_fields=' for Hyrax::ImageForm:Class
    # self.primary_fields = [:title, :creator, :rights_statement]
    include ESSI::ImageFormBehavior
    # @todo - add to m3 generator
    include M3::DynamicFormBehavior
    # @todo - sometimes all the fields go after the 'Additional Fields' button
    # @todo - contextual form labels
  end
end
