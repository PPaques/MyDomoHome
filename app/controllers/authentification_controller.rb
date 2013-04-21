# -*- encoding : utf-8 -*-
class AuthentificationController < ApplicationController
  layout "identification"

  def login
  	# Si on accède avec la méthode post, on vérifie le login
  	if request.request_method_symbol == :post
  		# Est ce qu'il existe une correspondance utilisateur - mot de passe ?
  		if User.exists?(:name => params[:name], :password => params[:password])
        # On récupère l'utilisateur qui nous intéresse
        user = User.where(:name => params[:name], :password => params[:password]).limit(1).first
  			# Oui : on connecte l'utilisateur, on enregistre son nom dans la variable de session user et on redirige vers root
  			flash[:success] = 'Vous avez été connecté avec succès'
  			session[:user] = user.name
        session[:user_id] = user.id
        session[:user_role] = user.role
        
  			# On redirige vers root
  			redirect_to root_path
		else
			# Non : erreur d'identification
			flash[:error] = 'Erreur : utilisateur ou mot de passe incorrect !'
			# On redirige dans tous les cas pour que l'utilisateur ne puisse pas reposter en rafraichissant la page.
			redirect_to :controller => "authentification", :action => "login"
		end

	 end

  end

  def logout
  	# Si la session existe effectivement, on la supprime et on notifie l'utilisateur
  	if session[:user]
  		reset_session
  		flash[:success] = 'Vous avez été déconnecté avec succès'
	end
	# On redirige vers la page de login
  	redirect_to :controller => "authentification", :action => "login"
  end
end
