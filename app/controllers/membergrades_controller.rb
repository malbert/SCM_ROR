class MembergradesController < ApplicationController
  
  respond_to :json, :html
  def create
    @membergrade = Membergrade.new(params[:membergrade])
    
    should_save = true;
    
    #membergrade = Membergrade.where("member_id = ? and club_id = ? and art_id = ?", params[:membergrade][:member_id], params[:membergrade][:club_id], params[:membergrade][:art_id]).first

    if (@membergrade.save)
        
    end
    respond_to do |format|
        member = Member.find(params[:membergrade][:member_id])
        membergrades =  member.membergrades.where("art_id = ? ",params[:membergrade][:art_id]).order("since_date ASC")
        format.js do
          render :partial => "grades/grades_list", :locals => { :membergrades => membergrades }, :layout => false
         
        end
        format.html { redirect_to(@member) }
        format.xml  { render :xml => @member, :status => :created }
      end
      
  end
  
  def new
    @membergrade = Membergrade.new(params[:membergrade])
    
    #membergrade = Membergrade.where("member_id = ? and club_id = ? and art_id = ?", params[:membergrade][:member_id], params[:membergrade][:club_id], params[:membergrade][:art_id]).first

    if (@membergrade.save)
        
    end
    respond_to do |format|
        member = Member.find(params[:membergrade][:member_id])
        membergrades =  member.membergrades.where("art_id = ? ",params[:membergrade][:art_id]).order("since_date ASC")
        format.js do
          render :partial => "grades/grades_list", :locals => { :membergrades => membergrades }, :layout => false
         
        end
        format.html { redirect_to(@member) }
        format.xml  { render :xml => @member, :status => :created }
      end
      
  end
  
  def edit
    
  end
  
end
