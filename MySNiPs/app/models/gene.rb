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

  scope :chromosome_contains, ->(chromosome) { where('chromosome LIKE ?', "%#{chromosome}%")}
  scope :summary_contains, ->(summary) { where('summary LIKE ?', "%#{summary}%")}
  scope :position_contains, ->(position) { where('position LIKE ?', "%#{position}%")}
end
