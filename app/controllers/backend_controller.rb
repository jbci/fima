class BackendController < ApplicationController
  include Wicked::Wizard
  before_action :authenticate_admin!
  before_action :set_rating

  steps :rating_definition, :posts, :areas, :evaluations

  def show
    case step
      when :posts
        @posts = Post.all.reverse
      when :areas
        @area_levels = AreaLevel.all
        @areas = Area.all
    end
    render_wizard
  end

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

  def rating_params
    params.require(:rating).permit(:id, :title, :description,
                                                sections_attributes: [:id, :title, :description, :_destroy,
                                                                      indicators_attributes: [:id, :title, :description, :_destroy]
                                                                      ])
  end
end
