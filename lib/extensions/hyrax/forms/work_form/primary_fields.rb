# Make primary_terms dependent on primary_fields instead of required_fields inference
module Extensions
  module Hyrax
    module Forms
      module WorkForm
        module PrimaryFields
          def self.included(base)
            base.class_eval do
              class_attribute :primary_fields
              self.primary_fields = []
        
              ##
              # Fields that are automatically drawn on the page above the fold
              #
              # @return [Enumerable<Symbol>] symbols representing each primary term
              def primary_terms
                primary = (primary_fields & terms)
            
                (primary_fields - primary).each do |missing|
                  Rails.logger.warn("The form field #{missing} is configured as a " \
                                    'primary field, but not as a term. This can lead ' \
                                    'to unexpected behavior. Did you forget to add it ' \
                                    "to `#{self.class}#terms`?")
                end
        
                (required_fields - primary).each do |missing|
                  Rails.logger.warn("The form field #{missing} is configured as a " \
                                    'required field, but not as a primary field. ' \
                                    'This can lead to unexpected behavior. Did you ' \
                                    'forget to add it to ' \
                                    "`#{self.class}#primary_fields`?")
                end
            
                primary
              end
            end
          end
        end
      end
    end
  end
end
