class ReportController < ApplicationController
  # GET /cards
  # GET /cards.json
  def index
    # Only a logged in user's cards will be displayed
    return login_url unless authorize

    @cards = Card.from_user(@current_user.id).get_genotypes_and_genes

    # Changes @cards
    apply_filters

    @all_cards = @cards

    # Changes @cards again, this time differing from all_cards
    execute_search

    @cards = @cards.paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def apply_filters
    @cards = @cards.min_mag(params[:min]) if params.has_key? :min
    @cards = @cards.max_mag(params[:max]) if params.has_key? :max
    @cards = @cards.repute_is(params[:rep]) if params.has_key? :rep
  end

  def execute_search
    @cards = @cards.search_for(params[:search]) if params.has_key? :search
  end
end
