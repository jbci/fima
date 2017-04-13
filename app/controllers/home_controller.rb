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

  def registration

  end

  def squeeze

    @initiatives = Post.where(area_id: 407)

    respond_to do |format|
      format.html { render }
      format.js { render :initiatives_data }
    end
  end


end
