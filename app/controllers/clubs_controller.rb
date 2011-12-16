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
    @members = @club.members.order("lastname").page(params[:page]).per(10)
    
    respond_to do |format|
      format.html 
      format.js do
        if (params[:pagination_context])
          case params[:pagination_context]
          when "members" 
            render :partial => "clubs/members_list", :locals => { :club => @club }, :layout => false 
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
    @club = Club.find(params[:id])
     
    # if the next fields are empty, fill them with examples (helpers)
    if (@club.accessibility == nil)
      @club.accessibility = t('club.examples.accessibility')
    end

    if (@club.contact  == nil)
      @club_owner = User.find_by_id(@club.owner_id)
      @contact_example = @club_owner.firstname + " " + @club_owner.lastname + "\n"
      @contact_example += "Tel : \n"
      @contact_example += "email : " + @club_owner.email
      @club.contact = @contact_example
    end

    if (@club.schedule == nil)
        @club.schedule = t('club.examples.schedule')
    end
  end
  
  # GET /clubs/1/edit_arts
  def edit_arts
    @club = Club.find(params[:id])
    @arts = @club.arts.find(:all , :conditions => ['enabled = 1'])
    if (@arts.count > 0)
      @available_arts = Art.find( :all, :conditions => ['template = 1 AND id not in (?)', @arts.map(&:template_id)], :order => 'name ASC')
    else
      @available_arts = Art.find(:all, :conditions => ['template = 1'], :order => 'name ASC')
      
    end
    
  end

  # POST /clubs
  # POST /clubs.xml
  def create
    @club = Club.new(params[:club])
    logger.info @club
    logger.info @club.users.empty?
    @club.users << current_user
    @club.owner_id = current_user.id
    respond_to do |format|
      if @club.save
        # format.html { redirect_to(@club, :notice => 'Club was successfully created.') }
        format.html { redirect_to( edit_public_club_path(@club.id)) }
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
