class School < ApplicationRecord
    has_many :tracks, dependent: :destroy
    has_many :courses, dependent: :destroy
    has_many :locations, dependent: :destroy

    validates_presence_of :name, :source_url
end
