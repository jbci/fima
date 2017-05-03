class HomeController < ApplicationController
  def index
    areas_with_posts = Area.joins(:posts).where('posts.area_id is not null').distinct
    areas_with_evaluations = Area.joins(:evaluations).where('evaluations.area_id is not null').distinct

    @carousel_data =[]
    Area.all.each_with_index do |a,i|
      @carousel_data.push({area_name: a.name})
    end
    @data = [[{:name => "Peñalolén",:num => 5}, {:name => "Las Condes",:num => 3}],
            [{:name => "Peñalolén",:num => 5}, {:name => "Las Condes",:num => 3}],
            [{:name => "Peñalolén",:num => 5}, {:name => "Las Condes",:num => 3}]]
  end

  def get_informed
  end

  # def initiatives
  #   if params[:area]
  #     area = Area.find params[:area]
  #     @initiatives = Post.where(area: area).page(params[:page]).per(3)
  #   end
  #
  #   respond_to do |format|
  #     format.html
  #     format.js { render :initiatives}
  #   end
  # end

  def cover
    render :layout => false
  end

  def registration
  end

  def about_us
  end

  def citizen_obs
    if params[:area]
      area = Area.find params[:area]
    else
      # area = Area.joins(:projects).where('projects.area_id is not null')
    end

    date = Project.arel_table[:end_date]
    @projects = Project.where(date.gt(Date.today - 1)).where(area: area)

    respond_to do |format|
      format.html { render :layout => "application_squeeze" }
    end
  end

  def initiatives
    if params[:area]
      area = Area.find params[:area]
    else
      area = Area.joins(:posts).where('posts.area_id is not null').first
    end
    @initiatives = Post.where(area: area)

    respond_to do |format|
      format.html { render :layout => "application_squeeze" }
      format.js { render :initiatives_data }
    end
  end

  def contact
  end

end
