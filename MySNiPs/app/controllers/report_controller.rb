class ReportController < ApplicationController
  # GET /cards
  # GET /cards.json
  def index
    @cards = define_user

    # Applies an eager_join so the other tables' columns can be used
    @cards = @cards.get_genotypes_and_genes

    apply_order

    # Both only change @cards if necessary
    apply_filters
    execute_search

    @cards = @cards.paginate(page: params[:page], per_page: 20)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def define_user
    # If there isn't a logged in user, an example report will be shown
    if @current_user.nil?
      Card.from_user(User.find_by(identifier: "0010000001").id)
    else
      Card.from_user(@current_user.id)
    end
  end

  def apply_order
    # :asc doesn't need to have any value, just needs to exist
    magnitude_direction = if params.has_key? :asc
                            "ASC"
                          else
                            "DESC"
                          end
    # It is necessary to make an order by ID after any other order
    # Due to a known bug in Will_Paginate that duplicates items
    @cards = @cards.order("genotypes.magnitude " + magnitude_direction, "genotypes.id ASC")
  end

  def apply_filters
    @cards = @cards.min_mag(params[:min]) if params.has_key? :min
    @cards = @cards.max_mag(params[:max]) if params.has_key? :max
    @cards = @cards.repute_is(params[:rep]) if params.has_key? :rep
  end

  def execute_search
    if params.has_key? :search
      @search = params[:search]
      @cards = @cards.search_for(params[:search])
    else
      @search = ""
    end
  end
end
