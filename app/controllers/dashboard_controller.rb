class DashboardController < ApplicationController
  layout "dashboard"
    
  def dashboard
    #take all the clubs the user is authorized to access.
    @clubs = current_user.clubs
  end
  
  def show
    @clubs = current_user.clubs
  end
  
end
