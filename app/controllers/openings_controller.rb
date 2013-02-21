class OpeningsController < ApplicationController
  # GET /openings
  # GET /openings.json
  def index
    @openings = Opening.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @openings }
    end
  end

  # GET /openings/1
  # GET /openings/1.json
  def show
    @opening = Opening.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @opening }
    end
  end

  # GET /openings/new
  # GET /openings/new.json
  def new
    @opening = Opening.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @opening }
    end
  end

  # GET /openings/1/edit
  def edit
    @opening = Opening.find(params[:id])
  end

  # POST /openings
  # POST /openings.json
  def create
    @opening = Opening.new(params[:opening])

    respond_to do |format|
      if @opening.save
        format.html { redirect_to @opening, notice: 'Opening was successfully created.' }
        format.json { render json: @opening, status: :created, location: @opening }
      else
        format.html { render action: "new" }
        format.json { render json: @opening.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /openings/1
  # PUT /openings/1.json
  def update
    @opening = Opening.find(params[:id])

    respond_to do |format|
      if @opening.update_attributes(params[:opening])
        format.html { redirect_to @opening, notice: 'Opening was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @opening.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /openings/1
  # DELETE /openings/1.json
  def destroy
    @opening = Opening.find(params[:id])
    @opening.destroy

    respond_to do |format|
      format.html { redirect_to openings_url }
      format.json { head :no_content }
    end
  end
end
