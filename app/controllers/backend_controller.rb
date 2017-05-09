class BackendController < ApplicationController

  layout 'backend'
  # include Wicked::Wizard
  before_action :authenticate_admin!
  before_action :set_rating, :set_page

  # steps :rating_definition, :posts, :areas, :evaluations

  def projects
    @projects = Project.order(created_at: :desc).page(@page).per(10)
    respond_to do |format|
      format.html
      format.js { render :projects}
    end
  end


  def posts
    @posts = Post.order(created_at: :desc).page(@page).per(10)
    respond_to do |format|
      format.html
      format.js { render :posts}
    end
  end

  def users
    @users = User.order(created_at: :desc).page(@page).per(10)
    respond_to do |format|
      format.html
      format.js { render :users}
      format.csv { send_data User.all.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def export_users
    @users = User.order(created_at: :desc).page(@page).per(10)
    respond_to do |format|
      format.html
      format.js { render :users}
    end
  end

  def areas
    @area_levels = AreaLevel.all
    @main_level = AreaLevel.first
    @areas = Area.all
    @countries = Area.paises.all
    respond_to do |format|
      format.html
      format.js { render :areas}
    end
  end


  def evaluations
    if params[:area].to_s != ""
      area = Area.find params[:area]
    else
      area = Area.joins(:evaluations).where('evaluations.area_id is not null')
    end

    if params[:indicator].to_s != ""
      indicator = Indicator.find params[:indicator]
    else
      indicator = Indicator.joins(:evaluations).where('evaluations.area_id is not null')
    end
    p "evals backend: " + area.to_s + " " + indicator.to_s
    @evaluations = Evaluation.where(area: area).where(indicator: indicator).page(@page).per(10)
    p "evals count: " + @evaluations.count.to_s

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

  def update
    @rating.update_attributes(rating_params)
    if request.xhr?
        @rating.save
        @errors = @rating.errors
        @errors.full_messages.each do |message|
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
                                                                      indicators_attributes: [:id, :title, :description, :number, :explanation, :icon, :_destroy]
                                                                      ])
  end
end
