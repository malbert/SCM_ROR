class GradesController < ApplicationController
  
  
  def index
    @art = Art.find(params[:art_id])
    respond_to do |format|
      format.html { 
        #redirect_to(club_arts_url(@club), :notice => 'Martial Art was successfully removed.') 

      }
      format.json  { 
        render :json => @art.to_json()
        return ;
      }
    end
  end
  
end
