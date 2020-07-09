class Console < ActiveRecord::Base
    belongs_to :user
    validates_presence_of :name, :release_year, :manufacturer
end