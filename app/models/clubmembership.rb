class Clubmembership < ActiveRecord::Base
  set_table_name :members_clubs
  belongs_to :member
  belongs_to :club
  
  validates_uniqueness_of :club_id, :scope => :member_id
  
  def get_status
    status = MembershipStatus::OK;
    if ( (licence_end_date != nil) && (Date.today > licence_end_date) )
      status = MembershipStatus::NOK;
    end
    
    if ( (insurance_end_date == nil) || (Date.today > insurance_end_date) )
      status = MembershipStatus::NOK;
    end
    return status;
  end
  
  def get_status_reason
    reason = Array.new;
    if ( (licence_end_date != nil) && (Date.today > licence_end_date))
      reason << MembershipStatusReason::LICENSE_EXPIRED;
    end
    
    if ( (insurance_end_date == nil) || (Date.today > insurance_end_date))
      reason << MembershipStatusReason::INSURANCE_EXPIRED;
    end
    
    if (reason.size() == 0)
      reason << MembershipStatusReason::NO_REASON
    end
    return reason;
  end
   
end

class MembershipStatus
  OK = "ok"
  NOK = "nok"
  UNDEFINED = "unknown"
end

class MembershipStatusReason
  NO_REASON = "no reason"
  LICENSE_EXPIRED = "expired_membership"
  INSURANCE_EXPIRED = "expired_insurance"
  OTHER = "other"
end