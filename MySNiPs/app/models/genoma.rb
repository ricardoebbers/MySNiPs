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

  def parse_file
    decoded_file = Base64.decode64(@raw_file) unless @raw_file.nil?
    @raw_file = nil
    return false if decoded_file.nil?

    update_attribute(:file, decoded_file)
    decoded_file = nil
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
