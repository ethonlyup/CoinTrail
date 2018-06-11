class Exchange < ApplicationRecord
	validates :base_endpoint, :name, presence: true, uniqueness: true
end
