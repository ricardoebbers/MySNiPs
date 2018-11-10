class ReportController < ApplicationController
  # GET /cards
  # GET /cards.json
  def index
    # Only their cards will be displayed
    # @cards = Card.where(user_id: @current_user.id).page(params[:page]).per(50) if authorize
    @cards = Card.where(user_id: @current_user.id).paginate(page: params[:page], per_page: 50) if authorize
  end
#temporary place for filters?
  def find_repute
    @cards = Card.Genotype.reputeIs(params[:reputeIs]) if params[:reputeIs].present?
  end

  def find_mag
    @cards = Card.Genotype.min_mag(params[:min_mag]).max_mag(params[:max_mag])
  end

  def find_all
    @cards = Card.Genotype.title_contains(params[:title_contains])
    .or(Card.Genotype.summary_contains(params[:summary_contains])
    .or(Card.Genotype.Gene.summary_contains(params[:summary_contains])
    .or(Card.Genotype.Gene.position_contains(params[:position_contains])
    .or(Card.Genotype.Gene.chromosome_contains(params[:chromosome_contains])))))
  end
end