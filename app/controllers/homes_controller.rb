# -*- encoding : utf-8 -*-
class HomesController < ApplicationController

  def update
    @home = Home.find(params[:id])

    respond_to do |format|
      if @home.update_attributes(params[:home])
        # format.html { redirect_to request.referer, notice: 'Home was successfully updated.' }
        format.html { redirect_to request.referer, notice: 'Maison mise à jour avec succès.' }
      else
        # format.html { redirect_to request.referer, notice: 'Error : Not updated.' }
        format.html { redirect_to request.referer, notice: 'Erreur : Mise à jour non réalisée' }
      end
    end
  end

end
