class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :parties
  has_many :guests, through: :parties
  has_secure_password

  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true

  def parties_invited_to
    Party.joins(:guests)
         .where('guests.user_id = ?', id)
  end
end
