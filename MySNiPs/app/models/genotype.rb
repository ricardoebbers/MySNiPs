class Genotype < ApplicationRecord
    belongs_to :gene
    validates :allele1, length: { is: 1 }
    validates :allele2, length: { is: 1 }
    validates :allele1, :allele2, :title, presence: true
end
