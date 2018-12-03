class Rating < ApplicationRecord
    belongs_to :school

    validates_presence_of :aggregate_rating, :review_count
end
