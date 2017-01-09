class Request < ActiveRecord::Base
  STATUSES = %w(Open InProgress Resolved Closed).freeze

  # Validations
  validates :title, :description, :status, :department_id, :requested_by, presence: true
  validates :status, inclusion: { in: STATUSES, message: '%{value} is not a valid Status' }
  validates :updated_by, numericality: { only_integer: true }, allow_nil: true
  validates :department_id, numericality: { only_integer: true }
  validates :requested_by, numericality: { only_integer: true }, allow_nil: true

  # Associations
  belongs_to :department
  belongs_to :requester, class_name: 'User', foreign_key: 'requested_by'
  belongs_to :updater, class_name: 'User', foreign_key: 'updated_by'

  # Callbacks
  before_save :generate_unique_id

  # Scopes
  scope :of_dept, ->(dept) { where(department_id: dept.id) }

  # Methods
  def generate_unique_id
    unique_id = "SR#{id.to_s.rjust(8, '0')}"
  end
end
