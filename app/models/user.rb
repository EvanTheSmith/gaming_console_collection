class User < ActiveRecord::Base
    has_secure_password
    has_many :consoles
    validates_presence_of :user_name, :password, :email
    validates_uniqueness_of :user_name, :email, :case_sensitive => false

    def slug
        self.user_name.parameterize
    end
    
    def self.find_by_slug(slug)
        self.find{|user| user.slug == slug}
    end
end