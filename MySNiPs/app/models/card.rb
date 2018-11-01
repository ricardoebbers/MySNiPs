class Card < ApplicationRecord
    belongs_to :genotype
    belongs_to :user
end
