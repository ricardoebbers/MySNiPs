class Genotype < ApplicationRecord
  belongs_to :gene
  has_many :cards
  has_many :users, :through => :cards
  validates :allele1, length: { is: 1 }
  validates :allele2, length: { is: 1 }
  validates :allele1, :allele2, presence: true
  validates :title, presence: true, uniqueness: true
  paginates_per 50
end
