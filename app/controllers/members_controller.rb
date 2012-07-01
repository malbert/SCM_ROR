class MembersController < ApplicationController
  
  # POST /members
  # POST /members.xml
  def create
    @club = Club.includes(:arts).find(params[:club_id])
    @member = Member.find_or_create(params[:member])
    @member.add_member_to_club(@club)
    
    respond_to do |format|
        @members = @club.members.order("lastname").page(params[:page]).per(10)
        format.js {
          render :partial => "members/members_list", :locals => { :club => @club }, :layout => false
        }
        format.html { redirect_to(@club) }
        format.xml  { render :xml => @member, :status => :created }
      end
  end
    
  
  def show
    @member = Member.find(params[:member_id])
    @club = Club.find(params[:club_id])
    @art = Art.new
  end
end