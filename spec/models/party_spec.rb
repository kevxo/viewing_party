require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'relationship' do
    it { should belong_to :user }
    it { should have_many :guests }
    it { should have_many(:users).through(:guests)}
  end
end
