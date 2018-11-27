require "rails_helper"

describe Api::V1::AuthenticationController, type: :controller do
  context "When given a valid login and password" do
    #role = Role.create(role_name: "laboratorio")
    #role = Role.find_by(role_name: "laboratorio")
    #puts role.id
    let!(:user) { create(:user, identifier: 001, password: 'test') }
    before {
      post 'authenticate',
      body: JSON.dump("identifier": '001', "password": 'test')
    }
    it "routes to /api/v1/authenticate to authentication#authenticate" do
      expect(post: "/api/v1/authenticate").to route_to("api/v1/authentication#authenticate")
    end
    #it "returns HTTP status 200" do
    #  expect(response).to have_http_status 200
    #end
  end
end
