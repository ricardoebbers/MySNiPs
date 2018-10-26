class Gene < ApplicationRecord
    has_many :genotypes
    validates :title, presence: true
end
