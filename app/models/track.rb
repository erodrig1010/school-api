class Track < ApplicationRecord
    belongs_to :school

    validates_presence_of :name, :url
end
