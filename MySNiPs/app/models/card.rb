class Card < ApplicationRecord
    belongs_to :genotype
    belongs_to :user

    validates :genotype_id, uniqueness: { scope: :user_id }
    self.per_page = 10
end
