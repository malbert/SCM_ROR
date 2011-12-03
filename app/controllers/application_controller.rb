class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery
  
  helper_method :current_user_session, :current_user
  
  before_filter :set_locale
  def store_location
    session[:return_to] = request.fullpath
  end

  def set_locale
    if (current_user)
      I18n.locale = current_user.language
    else
      I18n.locale = params[:locale] || I18n.default_locale
      
    end
  end

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
        
end
