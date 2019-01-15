class ReportController < ApplicationController
  # GET /cards
  # GET /cards.json
  def reset_filters
    redirect_to :report_index
  end

  def index
    @cards = Card.from_user(example_or_logged_in)
    @all_cards = @cards

    # Applies an eager_join so the other tables' columns can be used
    @cards = @cards.eager_join_tables

    apply_order
    # Both only change @cards if necessary
    apply_filters
    execute_search

    @found_cards = @cards
    @cards = @cards.paginate(page: params[:page], per_page: 20)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def persistent_repute
    case params[:rep]
    when "1"
      @repute1 = true
      @repute2 = false
    when "2"
      @repute1 = false
      @repute2 = true
    else
      @repute1 = false
      @repute2 = false
    end
  end

  def persistent_magnitude
    @min = 0
    @max = 10

    @min = params[:min] if params.has_key? :min
    @max = params[:max] if params.has_key? :max
  end

  def example_or_logged_in
    # If there isn't a logged in user, an example report will be shown
    if current_user.nil?
      user = User.find_by(identifier: "0010000001")
      if user.nil?
        @user_identifier = "nil"
        0
      else
        @user_identifier = "Example"
        user.id
      end
    else
      @user_identifier = current_user.identifier
      current_user.id
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
    persistent_repute
    persistent_magnitude
    @cards = @cards.min_mag(params[:min]) if params.has_key? :min
    @cards = @cards.max_mag(params[:max]) if params.has_key? :max
    @cards = @cards.repute_is(params[:rep]) if params.has_key? :rep
  end

  def execute_search
    return unless params.has_key? :search

    @search = params[:search]
    tokens = tokenize(@search)
    @cards = @cards.search_for_many(tokens)
  end

  def tokenize(text)
    # It breakes if there is an odd number of quotes, so the last one is deleted
    text = text.gsub(/(.*)"/, '\1') if text.scan(/"/).count.odd?
    # A split that ignores text inside double quotes, "like this"
    arr = text.split(/\s(?=(?:[^"]|"[^"]*")*$)/)
    # Ignores whitespaces
    arr = arr.reject(&:empty?)
    # And removes the double quotes
    arr.map {|s| "%#{s.gsub(/(^ +)|( +$)|(^["]+)|(["]+$)/, '')}%" }
  end
end
