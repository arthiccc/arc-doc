class Department < ApplicationRecord
  has_many :users
  has_many :categories, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
end
