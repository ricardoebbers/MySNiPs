class Genoma < ApplicationRecord
  #before_validation :parse_file
  belongs_to :user
  #attr_accessor :raw_file

  def to_json_view
    {
      status:     status,
      updated_at: updated_at
    }
  end

  def match_complete
    update_attribute(:file, nil)
    update_attribute(:status, 0)
  end

  def match_error
    update_attribute(:file, nil)
    update_attribute(:status, 2)
  end
end
