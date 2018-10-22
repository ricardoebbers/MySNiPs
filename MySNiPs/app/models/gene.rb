class Gene < ApplicationRecord
    has_many :genotypes, dependent: :destroy
end
