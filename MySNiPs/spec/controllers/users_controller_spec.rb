require "rails_helper"

describe UsersController do
  it "should validate a new User" do
    role = Role.create(role_name: "test")

    user = User.new(identifier: "1234567", password: "12345", role_id: role.id)
    expect(user.valid?).to eq true
  end

  it "should not validate a identifier-less User" do
    role = Role.new(role_name: "test")

    user = User.new(password: "12345", role_id: role.id)
    expect(user.valid?).to eq false
  end

  it "should not validate a password-less User" do
    role = Role.create(role_name: "test")

    user = User.new(identifier: "1234567", role_id: role.id)
    expect(user.valid?).to eq false
  end

  it "should not validate a role-less User" do
    user = User.new(identifier: "1234567", password: "12345")
    expect(user.valid?).to eq false
  end
end
