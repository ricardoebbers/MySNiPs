class Card < ApplicationRecord
    belongs_to :genotype
    belongs_to :user

    validates :genotype_id, uniqueness: { scope: :user_id }
    paginates_per 50
end
