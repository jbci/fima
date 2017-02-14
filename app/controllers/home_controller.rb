class HomeController < ApplicationController
  def index
  end

  def get_informed
  end

  def initiatives
    p 'debug initiatives '
    if params[:area]
      area = Area.find params[:area]
      @initiatives = Post.where(area: area).page(params[:page]).per(3)
    end

    respond_to do |format|
      p format
      format.html
      format.js { render :initiatives}
    end
  end


end
