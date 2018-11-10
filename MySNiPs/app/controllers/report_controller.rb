class ReportController < ApplicationController
  # GET /cards
  # GET /cards.json
  def index
    # Only their cards will be displayed
    # @cards = Card.where(user_id: @current_user.id).page(params[:page]).per(50) if authorize
    return redirect_to login unless authorize

    @cardsfull = Card.from_user(@current_user.id)

    # filters
    @cards = @cardsfull

    if params.has_key? :search
      find_all
    end
    @cards = @cards.paginate(page: params[:page], per_page: 50)
  end

  def find_repute
    @cards = Card.Genotype.reputeIs(params[:reputeIs]) if params[:reputeIs].present?
  end

  def find_mag
    @cards = Card.Genotype.min_mag(params[:min_mag]).max_mag(params[:max_mag])
  end

  def find_all
    @cards = @cards.search_for(params[:search])
  end
end
