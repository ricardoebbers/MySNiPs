class ReportController < ApplicationController
  # GET /cards
  # GET /cards.json
  def index
    # Only a logged in user's cards will be displayed
    return redirect_to login unless authorize

    all_cards = Card.from_user(@current_user.id)

    @cards = all_cards
    @cards = @cards.get_genotypes_and_genes unless params.empty?

    apply_filters
    execute_search if params.has_key? :search

    #@count = @cards.size
    @cards = @cards.paginate(page: params[:page], per_page: 50)
  end

  def apply_filters
    @cards = @cards.min_mag(params[:min]) if params.has_key? :min
    @cards = @cards.max_mag(params[:max]) if params.has_key? :max
    @cards = @cards.repute_is(params[:rep]) if params.has_key? :rep
  end

  def execute_search
    @cards = @cards.search_for(params[:search])
  end
end
