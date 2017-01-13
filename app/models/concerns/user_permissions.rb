module UserPermissions
  extend ActiveSupport::Concern

  def admin?
    role == 'Admin'
  end

  def agent?
    role == 'Agent'
  end

  def customer?
    role == 'Customer'
  end

  def can_access?(resource)
    return true if admin?
    case resource.class.to_s
    when 'Request'
      (department_id == resource.department_id) || (id == resource.requested_by)
    when 'User'
      id == resource.id
    end
  end

  def accessible_users
    case role
    when 'Admin'
      User.all
    when 'Agent'
      department_users
    when 'Customer'
      [self]
    end
  end

  def accessible_requests
    case role
    when 'Admin'
      Request.all
    when 'Agent'
      department_requests
    when 'Customer'
      my_requests
    end
  end

  def accessible_departments
    agent? ? [department] : Department.all
  end
end
