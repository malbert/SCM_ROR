class UserSessionsController < ApplicationController
  
  def new
    @user_session = UserSession.new
      redirect_to root_path
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Vous etes maintenant connecte"
      redirect_to root_path
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    
    @user_session = UserSession.new
    flash[:notice] = "Vous etes maintenant deconnecte"
    redirect_to root_path
  end
  
  def show
    @user_session = UserSession.new
    redirect_to root_path
    
  end
  
end
