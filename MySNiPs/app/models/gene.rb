class Gene < ApplicationRecord
  has_many :genotypes
  validates :title, presence: true, uniqueness: true
end
