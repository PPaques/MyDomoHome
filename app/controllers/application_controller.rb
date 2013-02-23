class ApplicationController < ActionController::Base

  # On vérifie TOUJOURS si l'utilisateur est loggé !
  before_filter :check_login
  # Sauf pour les pages login et logout
  skip_before_filter :check_login, :only=> [:login, :logout]

  protect_from_forgery


    def check_login
        if !session[:user]
            redirect_to :controller => "authentification", :action => "login"
        end
    end  
end
