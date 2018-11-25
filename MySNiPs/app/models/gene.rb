class Gene < ApplicationRecord
  has_many :genotypes
  validates :title, presence: true, uniqueness: true
  paginates_per 50

  def gmaf_text
    if gmaf.nil?
      ""
    else
      ((gmaf * 200).to_i).to_s + "% common"
    end
  end
end
