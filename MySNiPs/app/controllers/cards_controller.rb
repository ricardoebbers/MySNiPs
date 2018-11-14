class CardsController < ApplicationController
  include ActiveModel::Serializers::JSON

  # GET /cards
  # GET /cards.json
  def index
    if params.key? :identifier
      user = User.find_by(identifier: params[:identifier])
      # If the user isn't found, the search will be empty
      user_id = if user.nil?
                  0
                else
                  user.id
                end
      # But if there's a user, only their cards will be displayed
      @cards = Card.where(user_id: user_id).page(params[:page])
    else
      # If there is no search, all cards will be displayed
      @cards = Card.page(params[:page])
    end
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    # ...
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
    # ...
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: "Card was successfully created." }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to card_url, notice: "Card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_card
    @card = Card.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def card_params
    params.fetch(:card, {})
  end
end
