require 'rails_helper'

RSpec.describe Track, type: :model do
    it { should belong_to(:school) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:url) }
end
