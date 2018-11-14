class ReportController < ApplicationController
  # GET /cards
  # GET /cards.json
  def index
    # If there isn't a logged in user, an example report will be shown
    @cards =  if @current_user.nil?
                Card.from_user(User.find_by(identifier: "0010000001").id)
              else
                Card.from_user(@current_user.id)
              end

    @cards = @cards.get_genotypes_and_genes.order("genotypes.magnitude DESC")

    # Changes @cards
    apply_filters
    execute_search

    @cards = @cards.paginate(page: params[:page], per_page: 20)

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
