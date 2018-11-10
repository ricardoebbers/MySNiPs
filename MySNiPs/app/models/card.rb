class Card < ApplicationRecord
  belongs_to :genotype
  has_one :gene, through: :genotype
  belongs_to :user
  validates :genotype_id, uniqueness: {scope: :user_id}
  self.per_page = 10

  scope :from_user, ->(user_id) { where("user_id = #{user_id}") }
  scope :get_genotypes_and_genes, -> { eager_load(:genotype).eager_load(:gene) }
  scope :min_mag, ->(min) { where("genotypes.magnitude >= #{min}") }
  scope :max_mag, ->(max) { where("genotypes.magnitude <= #{max}") }
  scope :repute_is, ->(chosen_repute) { where("genotypes.repute = ?", chosen_repute) }
  scope :search_for, ->(search) {
    where("
      (genotypes.title ILIKE '%#{search}%')
      OR (genotypes.summary ILIKE '%#{search}%')
      OR (genotypes.page_content ILIKE '%#{search}%')
      OR (genes.summary ILIKE '%#{search}%')")
  }
end
