class ReportController < ApplicationController
  # GET /cards
  # GET /cards.json
  def index
    # Only their cards will be displayed
    # @cards = Card.where(user_id: @current_user.id).page(params[:page]).per(50) if authorize
    return redirect_to login unless authorize

    if params.has_key? :search
      find_summary
    else
      @cards = Card.from_user(@current_user.id).paginate(page: params[:page], per_page: 50)
    end
  end
#temporary place for filters?
  def find_repute
    @cards = Card.Genotype.reputeIs(params[:reputeIs]) if params[:reputeIs].present?
  end

  def find_mag
    @cards = Card.Genotype.min_mag(params[:min_mag]).max_mag(params[:max_mag])
  end

  def find_summary
    @cards = Card .from_user(@current_user.id)
                  .eager_load(:genotype)
                  .merge(Genotype.summary_contains(params[:search]))
                  .paginate(page: params[:page], per_page: 50)
  end

  def find_all
    @cards = Card .from_user(@current_user.id)
                  .eager_load(:genotype)
                  .eager_load(:gene)
                  .merge(Genotype.title_contains(params[:search]))
                  .or(merge(Genotype.summary_contains(params[:search]))
                  .or(merge(Gene.summary_contains(params[:search]))
                  .or(merge(Gene.chromosome_contains(params[:search])))))
                  .paginate(page: params[:page], per_page: 50)
  end
end
