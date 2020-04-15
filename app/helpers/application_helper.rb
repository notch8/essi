module ApplicationHelper
  def display_for(role_name)
    yield if current_user.roles.include? Role.where(name: role_name).first
  end

  def flash_messages
    flash.map do |type, text|
      { id: text.object_id, type: type, text: text }
    end
  end
end
