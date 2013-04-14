class HomesController < ApplicationController


  # PUT /homes/1
  # PUT /homes/1.json
  def update
    @home = Home.find(params[:id])

    respond_to do |format|
      if @home.update_attributes(params[:home])
        format.html { redirect_to parameters_url, notice: 'Home was successfully updated.' }
      else
        format.html { redirect_to parameters_url, notice: 'Error : Not updated.' }
      end
    end
  end

end
