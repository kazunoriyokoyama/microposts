class User < ActiveRecord::Base
     before_save { self.email = email.downcase }
     validates :name, presence: true, length: { maximum: 50 }
     VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
     validates :email, presence: true, length: { maximum: 255 }, on: :create,
                       format: { with: VALID_EMAIL_REGEX }, on: :create,
                       uniqueness: { case_sensitive: false }, on: :create
     validates :email, presence: true, on: :update
                       
     validates :area, presence: true               
     has_secure_password
end
