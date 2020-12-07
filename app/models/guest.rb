class Guest < ApplicationRecord
  belongs_to :user
  belongs_to :party
  alias_attribute :guest_id, :user_id
end
