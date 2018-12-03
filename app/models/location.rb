class Location < ApplicationRecord
    belongs_to :school

    validates_presence_of :city, :state, :country
end
