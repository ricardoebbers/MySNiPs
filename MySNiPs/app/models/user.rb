class User < ApplicationRecord
	has_many :cards
	has_many :genomas
	has_many :genotypes, :through => :cards
	belongs_to :role

	has_secure_password
	# Verify that identifier field is not blank and that it doesn't already exist in the db (prevents duplicates):
	validates :identifier, presence: true, uniqueness: true
end
