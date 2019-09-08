
class Ticket < ActiveRecord::Base
  belongs_to :project
  has_many :tag_tickets
  has_many :tags, through: :tag_tickets
  validates :name, :body, :status, presence: true

  STATUSES = ['new', 'blocked', 'in_progress', 'fixed']
end