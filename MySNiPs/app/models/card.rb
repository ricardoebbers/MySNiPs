class Card < ApplicationRecord
  belongs_to :genotype
  has_one :gene, through: :genotype
  belongs_to :user
  validates :genotype_id, uniqueness: {scope: :user_id}
  self.per_page = 10

  scope :from_user, ->(user_id) { where("user_id = #{user_id}")}
  scope :search_for, ->(search) {
    eager_load(:genotype)
      .eager_load(:gene)
      .where("
              (genotypes.title ILIKE '%#{search}%')
              OR (genotypes.summary ILIKE '%#{search}%')
              OR (genotypes.page_content ILIKE '%#{search}%')
              OR (genes.summary ILIKE '%#{search}%')")
  }
end
