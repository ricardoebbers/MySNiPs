require "rails_helper"

describe ReportController, type: :controller do
  context "GET index" do
    context "is" do
      it "a success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "an html response" do
        get :index
        expect(response.headers["Content-Type"]).to eq "text/html; charset=utf-8"
      end

      it "an example report" do
        get :index
        expect(controller.current_identifier).to eq("Relatório Exemplo")
      end
    end

    context "filters" do
      it "unset by default" do
        get :index
        expect(assigns(:min)).to eq 0
        expect(assigns(:max)).to eq 10
        expect(assigns(:repute1)).to eq false
        expect(assigns(:repute2)).to eq false
      end

      it "change according to params" do
        params = {
          min:    "1",
          max:    "9",
          rep:    "1",
          search: "Testing"
        }
        get :index, params: params
        expect(assigns(:min)).to eq params[:min]
        expect(assigns(:max)).to eq params[:max]
        expect(assigns(:repute1)).to eq(params[:rep] == "1")
        expect(assigns(:repute2)).to eq(params[:rep] == "2")
        expect(assigns(:search)).to eq params[:search]
      end
    end

    context "with a logged in user" do
      let(:role) { Role.create(role_name: "usuario final") }
      let(:user) { User.create(identifier: "0000000000", password: "000000", role_id: role.id) }
      let(:gene) { Gene.create(title: "Test") }
      let(:geno) { Genotype.create(title: "Test", allele1: "G", allele2: "G", magnitude: 5, repute: 2, gene_id: gene.id) }
      let(:card) { Card.create(user_id: user.id, genotype_id: geno.id) }
      before { allow(controller).to receive(:current_user) { user } }

      it "to have a correct identifier" do
        get :index
        expect(controller.current_identifier).to eq user.identifier
      end

      it "result in all cards by default" do
        get :index
        puts Card.from_user(user.id)
        expect(assigns(:total_cards) == assigns(:found_cards)).to be true
      end

      it "to have the right amount of cards" do
        @user = Factory(user, active: true)
        get :index
        expect(assigns(:total_cards)).to eq 1
      end
    end
  end
end
