class HomesController < ApplicationController

  def update
    @home = Home.find(params[:id])

    respond_to do |format|
      if @home.update_attributes(params[:home])
        format.html { redirect_to request.referer, notice: 'Home was successfully updated.' }
      else
        format.html { redirect_to request.referer, notice: 'Error : Not updated.' }
      end
    end
  end

end
