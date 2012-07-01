class DashboardController < ApplicationController
  layout "dashboard"
    
  def dashboard
    @presenter = Clubs::IndexPresenter.new(current_user)
  end
  
  def show
    @presenter = Clubs::IndexPresenter.new(current_user)
  end
  
end
