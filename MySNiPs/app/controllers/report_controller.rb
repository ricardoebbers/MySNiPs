class ReportController < ApplicationController
  # GET /cards
  # GET /cards.json
  def index
    # Only their cards will be displayed
    @cards = Card.where(user_id: @current_user.id).page(params[:page]).per(5) if authorize
  end
end
