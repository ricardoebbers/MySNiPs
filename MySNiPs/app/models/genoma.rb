class Genoma < ApplicationRecord
  mount_base64_uploader :genomafile, GenomaFileUploader
  before_validation :parse_file
  belongs_to :user
  validates :file, presence: true, uniqueness: true
  attr_accessor :raw_file

  def to_json_view
    {
      status:     status,
      updated_at: updated_at
    }
  end

  def parse_file
    puts "PARSING FILE FOR " + user.identifier
    path = make_path
    decoded_file = Base64.decode64(@raw_file) unless @raw_file.nil?
    return false if decoded_file.nil?

    File.open(path, "w") {|f| f.write(decoded_file) }
    update_attribute(:file, path)
  end

  def make_path
    # Separate in folders by laboratory later
    Rails.root.join("data", "genomas", user.identifier + ".gnm")
  end
end
