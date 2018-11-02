class User < ApplicationRecord
	has_secure_password
	has_many :cards
	has_many :genotypes, :through => :cards

	# Verify that identifier field is not blank and that it doesn't already exist in the db (prevents duplicates):
	validates :identifier, presence: true, uniqueness: true
end
