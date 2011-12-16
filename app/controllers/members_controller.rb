class MembersController < ApplicationController
  
  # POST /members
  # POST /members.xml
  def create
    @club = Club.find(params[:club_id])
    logger.info @club
    
    @member = Member.new(params[:member])
    
 
    if @member.save
      respond_to do |format|
        @club.members << @member
        @members = @club.members.order("lastname").page(params[:page]).per(10)
        format.js do
          render :partial => "clubs/members_list", :locals => { :club => @club }, :layout => false
         
        end
        format.html { redirect_to(@club) }
        format.xml  { render :xml => @member, :status => :created }
      end
    else
      # format.html { redirect_to(@club) }
      # format.html { render :action => "new" }

      #format.json format.json  { 
      #  render :json => '{"error" : "issue during creation"}'
      #  return ;
      #}
      format.js 
      format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }

    end
  end
  
  def show
    
  end
end