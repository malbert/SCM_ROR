class MembersController < ApplicationController
  
  # POST /members
  # POST /members.xml
  def create
    birthdate = Date.new(params[:member]["birthdate(1i)"].to_i, params[:member]["birthdate(2i)"].to_i, params[:member]["birthdate(3i)"].to_i)
    @member = Member.find_or_initialize_by_lastname_and_firstname_and_birthdate(params[:member][:lastname], params[:member][:firstname], birthdate)
    @member.phone = params[:member][:phone]
    @member.email = params[:member][:email]
    
    if (@member.save)
      @club = Club.find(params[:club_id])
      @member.add_member_to_club(@club)
      
      respond_to do |format|
        @members = @club.members.order("lastname").page(params[:page]).per(10)
        #format.js { render :partial => "members/members_list", :locals => { :club => @club }, :layout => false }
        format.html { redirect_to(@club) }
        format.json {render json: @member.to_json() }
      end
    else
      respond_to do |format|
        format.html { redirect_to(@club) }
        format.json { render json: @member.errors, :status => 422 }
      end
    end
  end
    
  
  def show
    @member = Member.find(params[:member_id])
    @club = Club.find(params[:club_id])
    @art = Art.new
  end
end