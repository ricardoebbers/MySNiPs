class Gene < ApplicationRecord
  has_many :genotypes
  validates :title, presence: true, uniqueness: true
  paginates_per 50

  def gmaf_text
    if gmaf.nil?
      ""
    else
      gmaf.to_s + "% common"
    end
  end

  scope :chromosome_contains, ->(chromosome) { where('chromosome ILIKE ?', "%#{chromosome}%")}
  scope :summary_contains, ->(summary) { where('summary ILIKE ?', "%#{summary}%")}
  scope :position_contains, ->(position) { where('position ILIKE ?', "%#{position}%")}
end
