class MembergradesController < ApplicationController
  
  respond_to :json, :html
  def create
    
    @membergrade = Membergrade.new(params[:membergrade])
    #membergrade = Membergrade.where("member_id = ? and club_id = ? and art_id = ?", params[:membergrade][:member_id], params[:membergrade][:club_id], params[:membergrade][:art_id]).first
    
    @membergrade.save
    respond_to do |format|
        format.js {render 'grades/create.js'}
        format.html { 
          member = Member.find(params[:membergrade][:member_id])
          redirect_to(member)   
        }
      end
      
  end
    
  def edit
    
  end
  
end
