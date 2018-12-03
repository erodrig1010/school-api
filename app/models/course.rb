class Course < ApplicationRecord
    belongs_to :school
    has_many :subjects

    validates_presence_of :name, :description, :url
end
