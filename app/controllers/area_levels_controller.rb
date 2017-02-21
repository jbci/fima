class AreaLevelsController < ApplicationController
  before_action :set_area_level, only: [:show, :edit, :update, :destroy]

  # GET /area_levels
  # GET /area_levels.json
  def index
    @area_levels = AreaLevel.all
  end

  # GET /area_levels/1
  # GET /area_levels/1.json
  def show
  end

  # GET /area_levels/new
  def new
    @area_level = AreaLevel.new
  end

  # GET /area_levels/1/edit
  def edit
  end

  # POST /area_levels
  # POST /area_levels.json
  def create
    @area_level = AreaLevel.new(area_level_params)

    respond_to do |format|
      if @area_level.save
        format.html { redirect_to @area_level, notice: 'AreaLevel was successfully created.' }
        format.json { render :show, status: :created, location: @area_level }
        format.js {
                      @area_level = @area_level.parent unless @area_level.nil?
                      @children = @area_level.children unless @area_level.nil?
                      render :children }
      else
        format.html { render :new }
        format.json { render json: @area_level.errors, status: :unprocessable_entity }
        format.js { render :create }
      end
    end
  end

  # PATCH/PUT /area_levels/1
  # PATCH/PUT /area_levels/1.json
  def update
    respond_to do |format|
      if @area_level.update(area_level_params)
        format.html { redirect_to @area_level, notice: 'AreaLevel was successfully updated.' }
        format.json { render :show, status: :ok, location: @area_level }
        format.js { render :update }
      else
        format.html { render :edit }
        format.json { render json: @area_level.errors, status: :unprocessable_entity }
        format.js { render :update }
      end
    end
  end

  # DELETE /area_levels/1
  # DELETE /area_levels/1.json
  def destroy
    @area_level.destroy
    respond_to do |format|
      format.html { redirect_to area_levels_url, notice: 'AreaLevel was successfully destroyed.' }
      format.json { head :no_content }
      format.js { render :delete }
    end
  end

  def children
    @area_level = AreaLevel.find(params[:area_level_id])
    @children = @area_level.children
    render :children
  end

  def new_child
    @area_level = AreaLevel.new
    @area_level.parent = AreaLevel.find(params[:area_level_id])
    render :new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area_level
      @area_level = AreaLevel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_level_params
      # params.fetch(:area_level, {})
      params.require(:area_level).permit(:id, :name, :parent_id)
    end
end
