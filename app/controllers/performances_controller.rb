class PerformancesController < ApplicationController
    before_filter :authenticate_user!, :only => [:create, :edit, :destroy, :update]
  def new
      @show = Show.find(params[:show_id])
      @performance = Performance.new()
      @venues = Venue.all
  end

  def create
      @performance = Performance.new(params[:performance])
      @show = Show.find(params[:performance][:show_id])
    respond_to do |format|
      if @performance.save
        format.html { redirect_to @performance, notice: 'Performance was successfully created.' }
        format.json { render json: @performance, status: :created, location: @performance }
      else
        format.html { render action: "new" }
        format.json { render json: @performance.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
      @date = params[:date] ? Date.parse(params[:date]) : [Performance.where('date > ?', DateTime.now).minimum(:date),DateTime.now].max.to_date
      @performances_by_date = Performance.all.group_by { |p| p.date.to_date }
      @performance = Performance.first
  end

  def show
      @performance = Performance.find(params[:id])
  end

  def destroy
  end

  def edit
      @performance = Performance.find(params[:id])
      @show = @performance.show
  end

  def update 
      @performance = Performance.find(params[:id])
      @performance.update_attributes(params[:performance])
    respond_to do |format|
      if @performance.save
        format.html { redirect_to @performance, notice: 'Performance was successfully updated.' }
        format.json { render json: @performance, status: :created, location: @performance }
      else
        format.html { render action: "edit" }
        format.json { render json: @performance.errors, status: :unprocessable_entity }
      end
    end
  end
end
