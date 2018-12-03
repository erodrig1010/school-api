class Subject < ApplicationRecord
    belongs_to :course

    validates_presence_of :name, :url
end
