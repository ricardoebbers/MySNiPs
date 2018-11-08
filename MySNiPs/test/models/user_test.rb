require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    Role.create(role_name: "admin")
    role = Role.find_by(role_name: "admin")
    @user = User.new(identifier: "admin",
                pass: "987987",
                password_digest: "$2a$10$KmZcwIwf6nHRR2iPv78lZOl1e5Q.oJ0NkmmWRqg7F5GS2dKi6puTy",
                role_id: role.id)
  end

  test "Usuário deve ter um role_id" do
    assert @user.valid?
  end
end
