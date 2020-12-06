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

    describe 'relationships' do
      it { should have_many :friendships }
      it { should have_many(:friends).through(:friendships) }
      it { should have_many :inverse_friendships }
      it { should have_many(:inverse_friends).through(:inverse_friendships) }

      it 'should have friends and inverse friends' do
        @current_user = create(:user)
        @users = create_list(:user, 5)

        @current_user.friendships.create!(friend_id: @users.first.id)
        @current_user.friendships.create!(friend_id: @users.second.id)

        @users.third.friendships.create!(friend_id: @current_user.id)

        expect(@current_user.friends).to eq([@users.first, @users.second])
        expect(@current_user.inverse_friends).to eq([@users.third])
      end
    end
  end
end
