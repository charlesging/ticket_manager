
# TODO: add validations for presence and uniqueness. also, that password validation will only fire on: :create

class User < ActiveRecord::Base
  has_secure_password
  
  validates :name, :email, presence: true
  validates :password, length: { minimum: 5 }
end