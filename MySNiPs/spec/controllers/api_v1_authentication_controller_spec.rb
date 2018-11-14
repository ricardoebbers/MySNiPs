require "rails_helper"

# Documentação da API
# https://github.com/ricardoebbers/MySNiPs/wiki/Documentação-da-API

describe Api::V1::AuthenticationController do
  it "should return an API key if the lab credentials is valid" do
    auth_token = authenticate("001", "654654")
    expect(auth_token).to have_key(:auth_token)
  end

  it "should return an error message if lab credentials are invalid" do
    auth_token = authenticate('001', 'abcdef')
    expect(auth_token).to have_key(:error)
  end
end
