require "rails_helper"

describe Genoma, type: :model do
  let(:role) { Role.create(role_name: "Test") }
  let(:user) { User.create(identifier: "0000000000", password: "000000", role_id: role.id) }
  let(:genoma) { described_class.new(user_id: user.id) }

  it "is valid with valid attributes" do
    expect(genoma).to be_valid
  end

  it "default status is not nil" do
    expect(genoma.status).to_not be_nil
  end

  it "is not valid without a user" do
    genoma.user_id = nil
    expect(genoma).to_not be_valid
  end

  it "deletes file after success or failure" do
    genoma.file = "Test"
    fail_genoma = genoma.dup

    genoma.match_complete
    expect(genoma.file.nil?).to be true

    fail_genoma.match_error
    expect(fail_genoma.file.nil?).to be true
  end
end
