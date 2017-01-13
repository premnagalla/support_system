module ApplicationHelper
  def accessible_departments_for_select
    current_user.accessible_departments.collect{|dept| [dept.name, dept.id]}
  end

  def accessible_users_for_select
    current_user.accessible_users.collect{|user| [user.full_name, user.id]}
  end
end
