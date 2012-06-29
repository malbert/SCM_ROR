class ArtsController < ApplicationController
  
  respond_to :json, :html
  #new_club_art GET    /clubs/:club_id/arts/new(.:format)      {:action=>"new", :controller=>"arts"}

  # /clubs/:club_id/art/new
  def new
    
    @club = Club.includes([:members, :arts]).find(params[:club_id])
    art_template_id = params[:template_id]
    art_template_name = params[:name]
    
    #Check first if this template wasn't already attribute to the club
    new_art = @club.arts.inactive.find_all_by_template_id(art_template_id).first
    if new_art
      new_art.enabled = 1
      new_art.save
    else
      new_art = Art.get_or_create_art_with_template(art_template_id, art_template_name, @club, current_user.language) 
    end
    
    #active the new arts for all club members
    @club.members.each { |member|
      member.create_or_enable_membergrades(new_art)
    }
    
    if @club.save
        respond_to do |format|
          format.html { redirect_to(club_arts_url(@club.id), :notice => 'Martial Art was successfully added.') }
          format.json  { render json: new_art.to_json()} 
        end
      else
        respond_to do |format|
          format.html { redirect_to(club_arts_url(@club.id), :notice => 'An error occured during the save. lLease try again.')  }
          format.json  { render json: new_art.to_json() }
        end
      end

  end
  
  def disable
    @club = Club.find(params[:club_id])
    @art = @club.arts.find(params[:art_id])
    
    if @art
      @art.enabled = false;
      @art.save
      respond_to do |format|
        logger.info format
          format.html { redirect_to(club_arts_url(@club.id), :notice => 'Martial Art was successfully removed.')}
          format.json  {render :json => @art.to_json() }
       end
    else
        respond_to do |format|
          format.html { 
            #redirect_to(club_arts_url(@club.id), :notice => 'An error occured during the save. Please try again.')
            
          }
          format.json  {render :json => @art.to_json() }
        end
    end
  end
  
  def generate_gradeform
    @art =  Art.find(params[:art_id])
    @member = Member.find(params[:member_id])
    @membergrade = Membergrade.new
    
    respond_to do |format|
      format.js do
          render :partial => "grades/member_grade_form", :layout => false
         
        end
        format.html { redirect_to(@member) }
    end
 
  end
  
end
