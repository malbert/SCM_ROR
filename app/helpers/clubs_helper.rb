module ClubsHelper

  def club_by_user_and_member(user, member)
    logger.debug 'find_by_user_and_member'
    logger.debug user.id
    logger.debug member.id
    ar = Array.new(1)
    ar << member
    clubs = user.clubs.joins(:members) & ar
    logger.debug clubs
    return clubs
  end
  
end
