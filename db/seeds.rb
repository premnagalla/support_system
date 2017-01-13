# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

DEPARTMENTS = ['Debit Cards', 'Credit Cards', 'Online Banking', 'Mobile Banking', 'Loans'].freeze
SERIES = %w(One Two Three).freeze

def create_request(title:, description:, department_id:, requested_by:)
  Request.create(title: title, description: description, status: 'Open', department_id: department_id,
                 requested_by: requested_by)
end

def create_user(first_name:, last_name:, department_id:, role:)
  email_id = "#{first_name.downcase}.#{last_name.downcase}@yopmail.com"
  User.create(first_name: first_name, last_name: last_name, email: email_id, password: 'Test1234',
                     password_confirmation: 'Test1234', department_id: department_id, role: role)
end

# Create Departments
departments = []
DEPARTMENTS.each do |name|
  departments << Department.create(name: name)
end

# Create Users
admins = []
agents = []
customers = []
# Create admins
2.times do |i|
  admins << create_user(first_name: "Admin#{i + 1}", last_name: SERIES[i], department_id: nil, role: 'Admin')
end
p "created #{admins.size} Admins"

departments.each do |department|
  # Create agents
  2.times do |i|
    agents << create_user(first_name: "Agent#{department.id}_#{i + 1}", last_name: SERIES[i], department_id: department.id,
                          role: 'Agent')
  end
  p "created #{agents.size} Agents"

  # Create Customers
  3.times do |i|
    customers <<  create_user(first_name: "Customer#{department.id}_#{i + 1}", last_name: SERIES[i],
                              department_id: nil, role: 'Customer')
  end
  p "created #{customers.size} Customers"
end

# Create Requests
customers.each do |customer|
  2.times do |i|
    request = create_request(title: "request_#{customer.id}_#{i + 1}",
                   description: "description_#{customer.id}_#{i + 1}",
                   department_id: departments.sample.id,
                   requested_by: customer.id)

    p request.errors.full_messages if request.errors.present?
  end
end
p "created #{Request.count} requests"
