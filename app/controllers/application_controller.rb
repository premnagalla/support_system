class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private

  def set_flash(resource, is_delete)
    flash_type, message = fix_type_and_messae(resource, is_delete)
    flash.now[flash_type] = message
  end

  def fix_type_and_messae(resource, is_delete)
    act = is_delete ? 'Deleted' : 'Saved'
    if resource.errors.blank?
      flash_type = :notice
      message = "#{resource.class} #{act} Successfully"
    else
      flash_type = :alert
      message = "Errors: #{resource.errors.full_messages.join(', ')}"
    end
    [flash_type, message]
  end
end
