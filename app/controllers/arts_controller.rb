class ArtsController < ApplicationController
  
  respond_to :json, :html
  #new_club_art GET    /clubs/:club_id/arts/new(.:format)      {:action=>"new", :controller=>"arts"}
  
  # /clubs/:club_id/art/new
  def new
    
    @club = Club.find(params[:club_id])
    @art_template_id = params[:template_id]
    
    #Check first if this template wasn't already attribute to the club
    @existing_art = @club.arts.find(:all, :conditions => ['template_id = ? AND enabled = 0', @art_template_id]).first
    if @existing_art
      @existing_art.enabled = 1
      @existing_art.save
      @new_art = @existing_art
    else
      if (params[:template_id])
        @art_template = Art.find(params[:template_id])
      else
        #check on the name....in case of twice inputs
        @art_template = Art.find(:all, :conditions => ['name = ?', params[:name]]).first
      end 

      if @art_template

        #ISSUE deep cloning doesnt' work... clone each grade manually
        #@new_art = @art_template.clone :included => :grades, :excluded => :id
        logger.info "template"
        logger.info @art_template
        @new_art = @art_template.apply_grade_template(@club, current_user.language)
        @club.arts << @new_art
        @club.save


        logger.info "new art"
        logger.info @new_art

        @new_art.template = false
        @new_art.template_id = @art_template_id
      else

        @new_art_template = Art.new
        @new_art_template.name = params[:name]
        @new_art_template.template = true
        @new_art_template.save

        @new_art = Art.new
        @new_art.name = params[:name]
        @new_art.template = false
        @new_art.template_id = @new_art_template.id

      end
      @new_art.save
      @club.arts << @new_art
    end
    
    if @club.save
        respond_to do |format|
          format.html {
            redirect_to(club_arts_url(@club.id), :notice => 'Martial Art was successfully added.') 
            
          }
          format.json  { 
            render :json => @new_art.to_json()
            return ;
          }
        end
      else
        respond_to do |format|
          format.html { 
            redirect_to(club_arts_url(@club.id), :notice => 'An error occured during the save. lLease try again.')
            
          }
          format.json  { 
            render :json => @new_art.to_json()
            return ;
          }
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
          format.html { 
            #redirect_to(club_arts_url(@club.id), :notice => 'Martial Art was successfully removed.') 
            
          }
          format.json  { 
            render :json => @art.to_json()
            return ;
          }
       end
    else
        respond_to do |format|
          format.html { 
            #redirect_to(club_arts_url(@club.id), :notice => 'An error occured during the save. Please try again.')
            
          }
          format.json  { 
            render :json => @art.to_json()
            return ;
          }
        end
    end
  end
  
end
