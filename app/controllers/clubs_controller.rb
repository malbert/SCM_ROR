class ClubsController < ApplicationController
  # GET /clubs
  # GET /clubs.xml


  def index
    #@clubs = Club.all

    #show only clubs we have access_to
    @clubs = current_user.clubs
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clubs }
    end
  end

  # GET /clubs/1
  # GET /clubs/1.xml
  def show
    @club = Club.find(params[:id])
    @member = Member.new
    @members = @club.members.page(params[:page]).per(10)
    
    respond_to do |format|
      format.html 
      format.js do
        if (params[:pagination_context])
          case params[:pagination_context]
          when "members" 
            render :partial => "members/members_list", :locals => { :club => @club }, :layout => false 
          end
        end
      end
      format.xml  { render :xml => @club }
    end
  end

  # GET /clubs/new
  # GET /clubs/new.xml
  def new
    @club = Club.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @club }
    end
  end

  # GET /clubs/1/edit
  def edit
    @club = Club.find(params[:id])
  end
  
  # GET /clubs/1/edit_public
  def edit_public
    @club = Club.find(params[:club_id])
    @club.fill_by_defaults(t('club.examples.accessibility'), t('club.examples.schedule')); 

  end
  
  # GET /clubs/1/edit_arts
  def edit_arts
    @club = Club.find(params[:club_id])
    @available_arts = @club.get_available_arts_template
  end

  # POST /clubs
  # POST /clubs.xml
  def create
    @club = Club.new(params[:club])
    @club.users << current_user
    @club.owner_id = current_user.id
    respond_to do |format|
      if @club.save
        # format.html { redirect_to(@club, :notice => 'Club was successfully created.') }
        format.html { redirect_to( club_edit_public_path(@club)) }
        format.xml  { render :xml => @club, :status => :created, :location => @club }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @club.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clubs/1
  # PUT /clubs/1.xml
  def update
    @club = Club.find(params[:id])

    respond_to do |format|
      if @club.update_attributes(params[:club])
        format.html { redirect_to(@club, :notice => 'Club was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @club.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /clubs/1/update_public
  def update_public
    @club = Club.find(params[:id])
    respond_to do |format|
      if @club.update_attributes(params[:club])
        format.html { redirect_to( edit_arts_club_path(@club.id)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit_public" }
        format.xml  { render :xml => @club.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /clubs/1/add_art
  def add_art
    
    
  end
  
  
  # DELETE /clubs/1
  # DELETE /clubs/1.xml
  def destroy
    @club = Club.find(params[:id])
    @club.destroy

    respond_to do |format|
      format.html { redirect_to(clubs_url) }
      format.xml  { head :ok }
    end
  end
  
  
  
  # -------------------------------------------------
  #                   Members
  # -------------------------------------------------
  
  def new_member
    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to(@club, :notice => 'Club was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @club.errors, :status => :unprocessable_entity }
      end
    end
  end
end
