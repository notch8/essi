#  models
AdminSet.class_eval do
  include M3::AdminSetBehavior
end

#  controllers
Hyrax::Admin::PermissionTemplatesController.prepend ::M3::PrependPermissionTemplatesController

#  forms
Hyrax::Forms::AdminSetForm.prepend ::M3::PrependAdminSetForm
Hyrax::Forms::PermissionTemplateForm.prepend ::M3::PrependPermissionTemplateForm