class UsersController < ApplicationController
  
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    @user_session = UserSession.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @user.prepare_for_update  
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @user_session = UserSession.new
    
    @language = Language.where("id = :id", { :id => @user.language}).first; 
    @user.language = @language.code;
    @country = Country.where("id = :id", { :id => @user.country}).first; 
    @user.country = @country.iso;
    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        @user.language = @language.id
        @user.country = @country.id
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    @language = Language.find(params[:user][:language]);
    params[:user][:language] = @language.code;
    
    @country = Country.find(params[:user][:country]);
    params[:user][:country] = @country.iso;
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        I18n.locale = params[:user][:language];
        
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        params[:user][:language] = @language.id
        params[:user][:country] = @country.id
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
end
