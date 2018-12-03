require 'rails_helper'

RSpec.describe School, type: :model do
  it { should have_many(:courses).dependent(:destroy) }
  it { should have_many(:tracks).dependent(:destroy) }
  it { should have_many(:locations).dependent(:destroy) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:source_url) }
end
