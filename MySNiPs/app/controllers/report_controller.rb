class ReportController < ApplicationController
  # GET /cards
  # GET /cards.json
  def index
    # Only their cards will be displayed
    # @cards = Card.where(user_id: @current_user.id).page(params[:page]).per(50) if authorize
    @cards = Card.where(user_id: @current_user.id).paginate(page: params[:page], per_page: 10) if authorize
  end
end
