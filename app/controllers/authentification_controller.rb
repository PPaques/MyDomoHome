class AuthentificationController < ApplicationController

  def login
  	# Si on accède avec la méthode post, on vérifie le login
  	if request.request_method_symbol == :post
  		# Est ce qu'il existe une correspondance utilisateur - mot de passe ?
  		if User.exists?(:name => params[:name], :password => params[:password])
  			# Oui : on connecte l'utilisateur, on enregistre son nom dans la variable de session user et on redirige vers root
  			flash[:success] = 'You have been successfully logged in'
  			session[:user] = params[:name]
  			# On redirige vers root
  			redirect_to root_path
		else
			# Non : erreur d'identification
			flash[:error] = 'Error : username/password incorrect !'
			# On redirige dans tous les cas pour que l'utilisateur ne puisse pas reposter en rafraichissant la page.
			redirect_to :controller => "authentification", :action => "login"
		end
	end
  end

  def logout
  	# Si la session existe effectivement, on la supprime et on notifie l'utilisateur
  	if session[:user]
  		reset_session
  		flash[:success] = 'You have been successfully logged out'
	end
	# On redirige vers la page de login
  	redirect_to :controller => "authentification", :action => "login"
  end
end
