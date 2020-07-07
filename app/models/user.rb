class User < ActiveRecord::Base
    has_secure_password
    has_many :consoles
    validates_presence_of :user_name, :password, :email
    validates_uniqueness_of :user_name, :email
end