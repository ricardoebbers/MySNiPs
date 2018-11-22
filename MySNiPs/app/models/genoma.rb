class Genoma < ApplicationRecord
  before_validation :parse_file
  belongs_to :user
  attr_accessor :raw_file

  def to_json_view
    {
      status:     status,
      updated_at: updated_at
    }
  end

  def parse_file
    decoded_file = Base64.decode64(@raw_file) unless @raw_file.nil?
    return false if decoded_file.nil?

    update_attribute(:file, decoded_file)
  end

  def delete_file_from_db
    update_attribute(:status, 0)
    update_attribute(:file, nil)
  end

  def mark_error
    update_attribute(:status, -1)
    update_attribute(:file, nil)
  end
end
