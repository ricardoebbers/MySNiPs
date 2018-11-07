class Gene < ApplicationRecord
  has_many :genotypes
  validates :title, presence: true, uniqueness: true
  paginates_per 50
end
