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
  default_scope { order(created_at: :desc) }
  scope :of_dept, ->(dept) { where(department_id: dept.id) }

  # Methods
  def generate_unique_id
    next_sequential_id = if Request.order('id desc').first.try(:unique_id)
                           Request.order('id desc').first.unique_id[2..10].to_i + 1
                         else
                           1
                         end
    self.unique_id = "SR#{next_sequential_id.to_s.rjust(8, '0')}"
  end
end
