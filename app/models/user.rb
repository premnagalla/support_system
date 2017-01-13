class User < ActiveRecord::Base
  include UserPermissions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable, :rememberable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :validatable
  DEPARTMENTS = ['Debit Cards', 'Credit Cards', 'Online Banking', 'Mobile Banking', 'Loans'].freeze
  ROLES = %w(Admin Agent Customer).freeze

  # Validations
  validates :first_name, presence: true, length: { in: 2..32 }
  validates :last_name, length: { in: 2..32 }, allow_nil: true
  validates :email, presence: true, uniqueness: true
  validates :department_id, presence: false, allow_nil: true, unless: :agent?
  validates :department_id, presence: true, numericality: { only_integer: true }, allow_nil: false, if: :agent?
  validates :role, presence: true, inclusion: { in: ROLES, message: '%{value} is not a valid Role' }

  # Associations
  belongs_to :department
  has_many :my_requests, class_name: 'Request', foreign_key: :requested_by

  delegate :requests, to: :department, prefix: true, allow_nil: true
  delegate :users, to: :department, prefix: true, allow_nil: true

  # Scopes
  default_scope { order(created_at: :desc) }
  ROLES.each do |user_role|
    scope user_role.downcase.pluralize.to_sym, -> { where(role: user_role) }
  end

  # Methods
  def full_name
    first_name + ' ' + last_name
  end
end
