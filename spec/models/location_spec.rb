require 'rails_helper'

RSpec.describe Location, type: :model do
    it { should belong_to(:school) }

    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:country) }
end
