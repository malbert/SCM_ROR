class MembersController < ApplicationController
  
  # POST /members
  # POST /members.xml
  def create
    @club = Club.find(params[:club_id])
    
    should_save = true;
    
    member = Member.find_by_email(params[:member][:email])
    if member
      membership = member.clubmemberships.find_all_by_club_id(@club);
      if membership
        # the member already exists for this club
        should_save = false
      end
    end
    
    if (should_save)
      @member = Member.new(params[:member])
    end
    
    if (should_save && @member.save)
        @club.members << @member
        #configure membership && set the initial grades
        @club.arts.where("enabled = ?", true).each do |art| 
          membergrade = Membergrade.new()
          membergrade.art_id = art.id
          first_grade = art.grades.where(:grade_order => 1).first
          membergrade.grade_id = first_grade.id
          membergrade.member_id = @member.id
          membergrade.save
        end
    end
    respond_to do |format|
        @members = @club.members.order("lastname").page(params[:page]).per(10)
        format.js do
          render :partial => "members/members_list", :locals => { :club => @club }, :layout => false
         
        end
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