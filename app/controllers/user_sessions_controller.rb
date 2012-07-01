class UserSessionsController < ApplicationController
  respond_to :html, :xml, :json

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
      redirect_to root_path
  end

  def create
   reset_session
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      respond_to do |format|
        format.html {
          flash[:notice] = "Vous etes maintenant connecte"
          redirect_to root_path
        }
        format.js {
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
        format.js {
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
