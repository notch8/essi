# Generated via
#  `rails generate hyrax:work Image`
module Hyrax
  # Generated form for Image
  class ImageForm < Hyrax::Forms::WorkForm
    self.model_class = ::Image
    self.terms += [:resource_type]
    self.required_fields -= [:keyword]
    # @todo - figure out why the form doens't always draw
    # undefined method `primary_fields=' for Hyrax::ImageForm:Class
    # self.primary_fields = [:title, :creator, :rights_statement]
    # @todo - add to m3 generator
    include M3::DynamicFormBehavior
    include ESSI::ImageFormBehavior
    
  end
end
