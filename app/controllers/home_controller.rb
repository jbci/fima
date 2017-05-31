class HomeController < ApplicationController
  def index
    areas_with_posts = Area.joins(:posts).where('posts.area_id is not null').distinct
    areas_with_evaluations = Area.joins(:evaluations).where('evaluations.area_id is not null').distinct

    @data = []

    Area.joins(:evaluations).where('evaluations.area_id is not null').distinct.each_with_index do |a,i|
      projects_count = Project.where(area: a).count
      indicator = Indicator.where(title: 'Sistema de Certificación Ambiental Municipal')
      evaluation = Evaluation.where(indicator: indicator).where(area: a).first
      value = ' inexistente'
      value = evaluation.value unless evaluation.nil?
      @data << { :name => a.name, :data => { :nota => a.posts_average, :certif => value, :projects => projects_count} }
    end
    if @data.size == 0
      @data << { :name => "sin datos", :data => { :nota => 0, :certif => 0, :projects => 0} }
    end

  end

  def get_informed
  end

  def cover
    render :layout => false
  end

  def registration
  end

  def about_us
  end

  def observations
    if params[:area]
      area = Area.find params[:area]
    else
      area = Area.joins(:projects).where('projects.area_id is not null')
    end

    date = Project.arel_table[:end_date]
    @projects = Project.where(date.gt(Date.today - 1)).where(area: area).order(:end_date)

    respond_to do |format|
      format.html { render :layout => "application_squeeze" }
      format.js { render :proj_carousel_data }
    end
  end

  def citizen_obs
    if params[:area]
      area = Area.find params[:area]
    else
      area = Area.joins(:projects).where('projects.area_id is not null')
    end

    date = Project.arel_table[:end_date]
    @projects = Project.where(date.gt(Date.today - 1)).where(area: area).order(:end_date)

    respond_to do |format|
      format.html { render :layout => "application_squeeze" }
      format.js { render :proj_carousel_data }
    end
  end

  def initiatives
    p "params[:area]"
    p params[:area]
    p "params[:area]"
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
