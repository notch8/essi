module M3Helper
  def selected_context(admin_set)
    return '' if admin_set.metadata_context.blank?
    admin_set.metadata_context.id
  end
end
