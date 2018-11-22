class AuthenticateUser
  prepend SimpleCommand

  def initialize(identifier, password)
    @identifier = identifier
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :identifier, :password

  def user
    user = User.find_by(identifier: @identifier)
    return user if user && user.authenticate(password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
