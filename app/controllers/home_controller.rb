class HomeController < ApplicationController
  def index
  end

  def get_informed
  end

  def initiatives
    if params[:area]
      area = Area.find params[:area]
      @initiatives = Post.where(area: area).page(params[:page]).per(3)
    end

    respond_to do |format|
      format.html
      format.js { render :initiatives}
    end
  end

  def cover
    render :layout => false
  end

  def squeeze

    @initiatives = Post.where(area_id: 407)
    
    respond_to do |format|
      format.html { render :layout => 'no-menu' }
      format.js { render :initiatives_data }
    end
  end


end
