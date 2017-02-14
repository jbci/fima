class BackendController < ApplicationController
  # include Wicked::Wizard
  before_action :authenticate_admin!
  before_action :set_rating, :set_page

  # steps :rating_definition, :posts, :areas, :evaluations

  def posts
    @posts = Post.order(created_at: :desc).page(@page).per(5)
    respond_to do |format|
      format.html
      format.js { render :posts}
    end
  end

  def areas
    @area_levels = AreaLevel.all
    @areas = Area.all
    respond_to do |format|
      format.html
      format.js { render :areas}
    end
  end


  def evaluations
    @area_levels = AreaLevel.all
    respond_to do |format|
      format.html
      format.js { render :evaluations}
    end
  end


  def rating_definition
    @rating = Rating.first
    respond_to do |format|
      format.html
      format.js { @rating.update_attributes(rating_params)
                  @errors = @rating.errors
                  render :update}
    end
  end

  # def show
  #   case step
  #     when :posts
  #       p 'aaaaaaaaqui'
  #       p @page
  #       p 'aaaaaaaaqui'
  #       @posts = Post.order(created_at: :desc).page(@page).per(5)
  #     when :areas
  #       @area_levels = AreaLevel.all
  #       @areas = Area.all
  #   end
  #   render_wizard
  # end
  #
  def update
    @rating.update_attributes(rating_params)
    if request.xhr?
        @rating.save
        @errors = @rating.errors
        @errors.full_messages.each do |message|
          p @errors
        end
    else
    end
  end

  private

  def set_rating
    # @rating = Rating.find params[:rating_id]
    @rating = Rating.first
  end

  def set_page
    if params[:page]
      @page = params[:page]
    else
      @page = 1
    end
  end

  def rating_params
    params.require(:rating).permit(:id, :title, :description,
                                                sections_attributes: [:id, :title, :description, :_destroy,
                                                                      indicators_attributes: [:id, :title, :description, :_destroy]
                                                                      ])
  end
end
