
class Project < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true

  has_many :tickets, dependent: :destroy

end