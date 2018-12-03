require 'rails_helper'

RSpec.describe Rating, type: :model do
    it { should belong_to(:school) }

    it { should validate_presence_of(:aggregate_rating) }
    it { should validate_presence_of(:review_count) }
end
