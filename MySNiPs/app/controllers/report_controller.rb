class ReportController < ApplicationController
  # GET /cards
  # GET /cards.json
  def index
    # Only a logged in user's cards will be displayed
    return login_url unless authorize

    all_cards = Card.from_user(@current_user.id)

    @cards = all_cards
    @cards = @cards.get_genotypes_and_genes unless params.empty?

    apply_filters_on @cards
    execute_search_on @cards if params.has_key? :search

    @cards = @cards.paginate(page: params[:page], per_page: 50)
  end

  def example
    @example_user = User.find_by(identifier: "0010000001") if @example_user.nil?
    return root_url if @example_user.nil?

    all_cards = Card.from_user(@example_user.id)

    @excards = all_cards
    @excards = @excards.get_genotypes_and_genes unless params.empty?

    apply_filters_on @excards
    execute_search_on @excards if params.has_key? :search

    @excards = @excards.paginate(page: params[:page], per_page: 50)
  end

  def apply_filters_on cards
    cards = cards.min_mag(params[:min]) if params.has_key? :min
    cards = cards.max_mag(params[:max]) if params.has_key? :max
    cards = cards.repute_is(params[:rep]) if params.has_key? :rep
  end

  def execute_search_on cards
    cards = cards.search_for(params[:search])
  end
end
