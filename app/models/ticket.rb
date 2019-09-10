
class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'

  has_many :comments, dependent: :destroy

  has_many :tag_tickets
  has_many :tags, through: :tag_tickets

  validates :name, :body, :status, presence: true
  STATUSES = ['new', 'blocked', 'in_progress', 'fixed']
end