class Genoma < ApplicationRecord
  before_validation :parse_file
  belongs_to :user
  has_attached_file :file
  attr_accessor :raw_file

  def to_json_view
    {
      status: status,
      updated_at: updated_at
    }
  end

  private

  def parse_file
    endfile = Paperclip.io_adapters.for(image_base)
    endfile.original_filename = identifier + ".gnm"
    self.file = endfile
  end
end
