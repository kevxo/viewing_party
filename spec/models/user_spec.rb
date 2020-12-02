require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }

    it "is valid with valid attributes" do
      user1 = create(:user)
      expect(user1).to be_valid
    end
  end
end