require "rails_helper"

RSpec.describe ReportController, type: :controller do
  context "GET index" do
    it "is a success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
