class ReportController < ApplicationController
  # GET /cards
  # GET /cards.json
  def index
    @cards = Card.from_user(example_or_logged_in)
    @total_cards = @cards.size

    # Applies an eager_join so the other tables' columns can be used
    @cards = @cards.eager_join_tables

    apply_order

    # Both only change @cards if necessary
    apply_filters
    execute_search

    @found_cards = @cards.size
    @cards = @cards.paginate(page: params[:page], per_page: 20)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def example_or_logged_in
    # If there isn't a logged in user, an example report will be shown
    if @current_user.nil?
      user = User.find_by(identifier: "0010000001")
      if user.nil?
        0
      else
        user.id
      end
    else
      @current_user.id
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
    execute_search
    @cards = @cards.min_mag(params[:min]) if params.has_key? :min
    @cards = @cards.max_mag(params[:max]) if params.has_key? :max
    @cards = @cards.repute_is(params[:rep]) if params.has_key? :rep
  end

  def execute_search
    if params.has_key? :search
      @search = params[:search].delete('"')
      @cards = @cards.search_for(@search.gsub("'", "''"))
    else
      @search = ""
    end
  end
end
