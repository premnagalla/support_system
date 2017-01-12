class Department < ActiveRecord::Base
  # Validations
  validates :name, presence: true, uniqueness: true, length: { in: 2..32 }

  # Associations
  has_many :users, dependent: :destroy
  has_many :requests, dependent: :destroy

  # Scopes
  default_scope { order(created_at: :desc) }
end
