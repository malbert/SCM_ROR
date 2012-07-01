class Clubs::IndexPresenter

  def initialize(user)
    @user = user
  end
  
  def owned_clubs
    @clubs ||= @user.clubs
  end
  
  def critic_members
    @critic_members ||= @user.members.should_pay.limit(10)
  end
  
end