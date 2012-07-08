class PublicController < ApplicationController
  
  def index
    @user_session = UserSession.new
  end
  
  def contactus
    @user_session = UserSession.new
  end

end
