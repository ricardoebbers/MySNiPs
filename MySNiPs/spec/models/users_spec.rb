require "rails_helper"

describe User, type: :model do
  let(:role) { create(:role) }
  let(:user) { create(:user) }

  it "is valid with valid attributes" do
    expect(user).to be_valid
  end

  it "is not valid without an identifier" do
    user.identifier = nil
    expect(user).to_not be_valid
  end

  it "is not valid if the identifier is duplicate" do
    user.save
    duplicate_user = user.dup
    duplicate_user.validate
    expect(duplicate_user.errors[:identifier].first).to eq "has already been taken"
  end

  it "is not valid if the identifier has letters" do
    user.identifier = "Letters"
    expect(user).to_not be_valid
  end

  it "is not valid if the identifier is too long" do
    user.identifier = "12345678901234567890"
    expect(user).to_not be_valid
  end

  it "formats integers and strings into identifier format" do
    expect(User.format_identifier_for(1, "1")).to eq("0010000001")
  end
end
