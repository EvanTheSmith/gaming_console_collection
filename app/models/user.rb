class User < ActiveRecord::Base
    has_secure_password
    has_many :consoles
    validates_presence_of :username, :password, :email
    validates_uniqueness_of :username, :email
end