class Category < ApplicationRecord
  belongs_to :department
  has_many :documents, dependent: :destroy
  
  validates :name, presence: true
end
