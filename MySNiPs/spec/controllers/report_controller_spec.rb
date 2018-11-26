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
      it "are unset by default" do
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
      let!(:user) { create(:user) }
      let!(:geno1) { create(:genotype, title: "Test1", repute: 0, magnitude: 1) }
      let!(:geno2) { create(:genotype, title: "Test2", repute: 1, magnitude: 5) }
      let!(:geno3) { create(:genotype, title: "Test3", repute: 2, magnitude: 9) }
      let!(:card1) { create(:card, genotype_id: geno1.id) }
      let!(:card2) { create(:card, genotype_id: geno2.id) }
      let!(:card3) { create(:card, genotype_id: geno3.id) }

      before { allow(controller).to receive(:current_user) { user } }

      it "has the right current identifier" do
        get :index
        expect(controller.current_identifier).to eq user.identifier
      end

      it "results in all cards by default" do
        get :index
        expect(assigns(:total_cards) == assigns(:found_cards)).to be true
      end

      it "has the right amount of cards" do
        get :index
        expect(assigns(:total_cards)).to eq 3
      end

      context "orders by" do
        it "descending magnitude" do
          get :index
          expect(assigns(:cards).to_a).to eq user.cards.to_a.reverse
        end
      end

      context "filters" do
        context "repute for" do
          it "good" do
            params = {rep: 1}
            get :index, params: params
            expect(assigns(:found_cards)).to eq 1
          end

          it "bad" do
            params = {rep: 2}
            get :index, params: params
            expect(assigns(:found_cards)).to eq 1
          end
        end

        context "magnitude for" do
          it "min" do
            params = {min: 6}
            get :index, params: params
            expect(assigns(:found_cards)).to eq 1
          end

          it "max" do
            params = {max: 4}
            get :index, params: params
            expect(assigns(:found_cards)).to eq 1
          end

          it "min and max" do
            params = {min: 4, max: 6}
            get :index, params: params
            expect(assigns(:found_cards)).to eq 1
          end
        end

        context "searches for a" do
          it "generic term" do
            params = {search: "Test"}
            get :index, params: params
            expect(assigns(:found_cards) == assigns(:total_cards)).to eq true
          end

          it "specific term" do
            params = {search: "Test1"}
            get :index, params: params
            expect(assigns(:found_cards)).to eq 1
          end
        end
      end
    end
  end
end
