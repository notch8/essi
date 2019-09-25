

# models
AdminSet.prepend M3::PrependAdminSet

# controllers
Hyrax::Admin::PermissionTemplatesController.prepend M3::PrependPermissionTemplatesController

# forms
Hyrax::Forms::PermissionTemplateForm.prepend M3::PrependPermissionTemplateForm
Hyrax::Forms::AdminSetForm.prepend M3::PrependAdminSetForm
