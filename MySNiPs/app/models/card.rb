class Card < ApplicationRecord
  belongs_to :genotype
  has_one :gene, through: :genotype
  belongs_to :user
  validates :genotype_id, uniqueness: {scope: :user_id}
  self.per_page = 10

  scope :from_user, ->(user_id) { where("user_id = ?", user_id) }
  scope :eager_join_tables, -> { eager_load(:genotype).eager_load(:gene) }
  scope :min_mag, ->(min) { where("genotypes.magnitude >= ?", min) }
  scope :max_mag, ->(max) { where("genotypes.magnitude <= ?", max) }
  scope :repute_is, ->(chosen_repute) { where("genotypes.repute = ?", chosen_repute) }
  scope :search_for, ->(search) {
    where("
      (genotypes.title ILIKE ?)
      OR (genotypes.summary ILIKE ?)
      OR (genotypes.page_content ILIKE ?)
      OR (genes.summary ILIKE ?)", search, search, search, search)
  }
  scope :search_for_many, ->(words) {
    final = []
    block = "((genotypes.title ILIKE ?)
    OR (genotypes.summary ILIKE ?)
    OR (genotypes.page_content ILIKE ?)
    OR (genes.summary ILIKE ?))"
    words.each do |word|
      sanitized_word = sanitize_sql_for_conditions(word)
      final.push(block.gsub('?', "'#{sanitized_word}'"))
    end
    sql = final.join(' OR ')
    where(sql)
  }

end
