class User < ApplicationRecord
  belongs_to :role
  has_one :genoma, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_one :genotype, dependent: :destroy, :through => :cards
  has_secure_password
  validates :identifier, presence: true, uniqueness: true
  validate :identifier_is_numbers_only
  validate :identifier_is_right_size

  IDENTIFIER_LENGTH = 7
  LAB_LENGTH = 3
  PASSWORD_LENGTH = 6

  def to_json_view
    {
      identifier: identifier,
      password:   password,
      updated_at: updated_at,
      last_login: last_login
    }
  end

  def identifier_is_numbers_only
    errors.add(:identifier, "Identifier should only contain numbers") unless identifier !~ /\D/
  end

  def identifier_is_right_size
    errors.add(:identifier, "Identifier can't be longer than #{IDENTIFIER_LENGTH}") if identifier.to_s.length > LAB_LENGTH + IDENTIFIER_LENGTH
  end

  # Transforms the id_number into a 7 digits string justified to the right with zeros
  # Then merges it with the lab identifier
  # Example: 001, 123 -> "0010000123"
  def self.format_identifier_for lab_identifier, id_number
    return id_number if lab_identifier == "admin"

    lab_identifier.to_s.rjust(LAB_LENGTH, "0") + id_number.to_s.rjust(IDENTIFIER_LENGTH, "0")
  end

  def self.generate_random_password
    # Generates a random string of 6 characters with numbers and lowcase letters
    numbers_and_letters = ("a".."z").to_a.size + (0..9).size # 36
    rand(numbers_and_letters**PASSWORD_LENGTH - 1).to_s(numbers_and_letters)
  end
end
