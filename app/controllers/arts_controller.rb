class ArtsController < ApplicationController
  
  respond_to :json, :html
  #new_club_art GET    /clubs/:club_id/arts/new(.:format)      {:action=>"new", :controller=>"arts"}
  
  # /clubs/:club_id/art/new
  def new
    
    @club = Club.find(params[:club_id])
    @art_template_id = params[:template_id]
    
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
    logger.info @new_art
    @new_art.save
    logger.info @new_art
    @club.arts << @new_art
    
    if @club.save
        respond_to do |format|
          format.html { redirect_to(@user, :notice => 'User was successfully created.') }
          format.json  { 
            @answer  = @new_art.to_json()
            logger.info @answer
            render :json => @answer
            return ;
          }
        end
      else
        respond_to do |format|
          format.html { render :action => "new" }
          format.json  { 
            @answer  = @new_art.to_json()
            logger.info @answer
            render :json => @answer
            return ;
          }
        end
      end

  end
  
end
