class Api < ApplicationRecord
  belongs_to :user
  belongs_to :exchange
  validates :publishable_key, :secret_key, presence: true, uniqueness: true
end
