class HomeController < ApplicationController
  def index
    areas_with_posts = Area.joins(:posts).where('posts.area_id is not null').distinct
    areas_with_evaluations = Area.joins(:evaluations).where('evaluations.area_id is not null').distinct

    @data = []

    Area.joins(:evaluations).where('evaluations.area_id is not null').distinct.each_with_index do |a,i|
      projects_count = Project.where(area: a).count
      indicator = Indicator.where(title: 'Sistema de Certificación Ambiental Municipal')
      evaluation = Evaluation.where(indicator: indicator).where(area: a).first
      value = 'No existe'
      value = evaluation.value unless evaluation.nil?
      @data << { :name => a.name, :data => { :nota => a.posts_average, :certif => value, :projects => projects_count} }
    end
    # @data = [[{:name => "Peñalolén",:num => 5}, {:name => "Peñalolén",:num => 6}, {:name => "Peñalolén",:num => 3}],
    #          [{:name => "Las Condes",:num => 9}, {:name => "Las Condes",:num => 9}, {:name => "Las Condes",:num => 9}]]
    # @data = [{:name => "Peñalolén", :data => { :val_1 => 3,:val_2 => 3,:val_3 => 3}},
    #   {:name => "Las casas", :data => { :val_1 => 4,:val_2 => 4,:val_3 => 4}},
    #   {:name => "Las Condes", :data => { :val_1 => 5,:val_2 => 5,:val_3 => 5}}]
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
