# -*- encoding : utf-8 -*-
class SetpointsController < ApplicationController
  # GET /setpoints
  # GET /setpoints.json
  def index
    @setpoints = Setpoint.unscoped.order("DATE_FORMAT(times, '%H'), day ASC").all(:include => :room)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @setpoints }
    end
  end

  # GET /setpoints/1
  # GET /setpoints/1.json
  def show
    @setpoint = Setpoint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @setpoint }
    end
  end

  # GET /setpoints/new
  # GET /setpoints/new.json
  def new
    @setpoint = Setpoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @setpoint }
    end
  end

  # GET /setpoints/1/edit
  def edit
    @setpoint = Setpoint.find(params[:id])
  end

  # POST /setpoints
  # POST /setpoints.json
  def create
    @setpoint = Setpoint.new(params[:setpoint])

    respond_to do |format|
      if @setpoint.save
        format.html { redirect_to @setpoint, notice: 'Consigne sauvée' }
        format.json { render json: @setpoint, status: :created, location: @setpoint }
      else
        format.html { render action: "new" }
        format.json { render json: @setpoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /setpoints/1
  # PUT /setpoints/1.json
  def update
    @setpoint = Setpoint.find(params[:id])

    respond_to do |format|
      if @setpoint.update_attributes(params[:setpoint])
        # format.html { redirect_to @setpoint, notice: 'Setpoint was successfully updated.' }
        format.html { redirect_to @setpoint, notice: 'Consigne mise à jour avec succès.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @setpoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /setpoints/1
  # DELETE /setpoints/1.json
  def destroy
    @setpoint = Setpoint.find(params[:id])
    @setpoint.destroy

    respond_to do |format|
      format.html { redirect_to setpoints_url }
      format.json { head :no_content }
    end
  end

  def update_multiple
    setpoint_ids = []
    params[:setpoints_update].each_with_index do |(key,value),index|
     setpoint_ids.push key
    end
    @setpoints = Setpoint.find(setpoint_ids)
    @setpoints.each do |setpoint|
      setpoint.update_attributes!(temperature: params[:setpoints_update][setpoint.id.to_s].to_f)
    end

    respond_to do |format|
      format.html { redirect_to setpoints_url }
      format.json { head :no_content }
    end
  end
end
