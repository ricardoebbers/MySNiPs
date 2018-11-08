class User < ApplicationRecord
	belongs_to :role
	has_one :genoma
	has_many :cards
	has_many :genotypes, :through => :cards

	has_secure_password
	# Verify that identifier field is not blank and that it doesn't already exist in the db (prevents duplicates):
	validates :identifier, presence: true, uniqueness: true

	def to_json_view
		{
			identifier: identifier,
			password: password,
			updated_at: updated_at,
			last_login: last_login
		}
	end
end
