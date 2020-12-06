class Party < ApplicationRecord
  belongs_to :user
  has_many :guests
  has_many :users, through: :guests
  alias_attribute :host_id, :user_id
end
