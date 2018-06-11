class Alert < ApplicationRecord	
	belongs_to :user
	validates :price_above, presence: true
end
