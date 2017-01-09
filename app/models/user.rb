class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable, :rememberable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :validatable
  DEPARTMENTS = ['Debit Cards', 'Credit Cards', 'Online Banking', 'Mobile Banking', 'Loans'].freeze
  ROLES = %w(Admin Agent Customer).freeze

  # Validations
  validates :first_name, presence: true, length: { in: 2..32 }
  validates :last_name, length: { in: 2..32 }, allow_nil: true
  validates :email, presence: true, uniqueness: true
  validates :department_id, presence: false, allow_nil: true, if: :admin?
  validates :department_id, presence: true, numericality: { only_integer: true }, allow_nil: false, unless: :admin?
  validates :role, presence: true, inclusion: { in: ROLES, message: '%{value} is not a valid Role' }

  # Associations
  belongs_to :department
  has_many :requests, foreign_key: :requested_by

  delegate :requests, to: :department, prefix: true, allow_nil: true

  # Scopes
  ROLES.each do |user_role|
    scope user_role.downcase.pluralize.to_sym, -> { where(role: user_role) }
  end
  scope :of_dept, ->(dept) { where(department_id: dept.id) }

  # Methods
  def admin?
    role == 'Admin'
  end

  def agent?
    role == 'Agent'
  end

  def customer?
    role == 'Customer'
  end
end
