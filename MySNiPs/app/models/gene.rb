class Gene < ApplicationRecord
    has_many :genotypes
    validates :title, :iid, :rsid, presence: true
end
