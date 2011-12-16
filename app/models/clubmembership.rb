class Clubmembership < ActiveRecord::Base
  set_table_name :members_clubs
  belongs_to :member
  belongs_to :clubs
  
  def get_status
    status = MembershipStatus::OK;
    if ( (insurance_end_date != nil) && (licence_end_date != nil) )
      if ( (Date.today > licence_end_date) || (Date.today > insurance_end_date))
        status = MembershipStatus::NOK;
      end
    else
      status = MembershipStatus::NOK;
    end
    return status;
  end
  
  def get_status_reason
    reason = MembershipStatusReason::NO_REASON;
    if ( (licence_end_date == nil) || (Date.today > licence_end_date))
      reason = MembershipStatusReason::LICENSE_EXPIRED;
    end
    
    if ( (insurance_end_date == nil) || (Date.today > insurance_end_date))
      reason = MembershipStatusReason::INSURANCE_EXPIRED;
    end
    return status;
  end
   
end

class MembershipStatus
  OK=0
  NOK=1
  UNDEFINED=2
end

class MembershipStatusReason
  NO_REASON = 0
  LICENSE_EXPIRED = 1
  INSURANCE_EXPIRED = 2
  OTHER = 999
end