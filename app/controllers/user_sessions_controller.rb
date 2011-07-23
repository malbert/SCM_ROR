class UserSessionsController < ApplicationController
respond_to :html, :xml, :json

  
  def new
    @user_session = UserSession.new
      redirect_to root_path
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    logger.info 'test'
    logger.info @user_session
    logger.info @user_session.save
    if @user_session.save
      respond_to do |format|
        logger.info format
        format.html {
          flash[:notice] = "Vous etes maintenant connecte"
          redirect_to root_path
        }
        format.json {
          @forward_url =  url_for(:action => 'show', :controller => 'dashboard', :only_path => false)
          @answer  = '{"status":"ok", "forward" : "' + @forward_url + '"}'
          logger.info @answer
          render :json => @answer
          return ;
        }
      end
        
    else
      
      respond_to do |format|
        logger.info format
        format.html {
          render :action => :new
        }
        format.json {
          render :json => '{"status":"error"}'
          
          return;
        }
        
      end
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
