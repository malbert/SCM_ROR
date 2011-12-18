class MembersController < ApplicationController
  
  # POST /members
  # POST /members.xml
  def create
    @club = Club.find(params[:club_id])
    logger.info @club
    @member = Member.find_by_email(params[:member][:email])
    
    if !(@member)
      @member = Member.new(params[:member])
    end
 
    if @member.save
      respond_to do |format|
        @club.members << @member
        
        #configure membership && set the initial grades
        @club.arts.each do |art| 
          membergrade = MemberGrade.new()
          membergrade.art_id = art.id
          first_grade = art.grades.where(:grade_order => 1).first
          membergrade.grade_id = first_grade.id
          membergrade.member_id = @member.id
          membergrade.save
        end
        
        @members = @club.members.order("lastname").page(params[:page]).per(10)
        format.js do
          render :partial => "members/members_list", :locals => { :club => @club }, :layout => false
         
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
    @member = Member.find(params[:member_id])
    @club = Club.find(params[:club_id])
  end
end