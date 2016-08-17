class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :except => [:check_email_availability]
  before_filter :check_for_pending_requests

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  rescue_from ActiveRecord::RecordNotFound do
  	flash[:warning] = 'Resource not found.'
  	redirect_back_or root_path
  end

  def redirect_back_or(path)
	redirect_to request.referer || path
  end

  def after_sign_in_path_for(resource)      
    sign_in_url = new_user_session_url
    mandatory_fields = [resource.gender_id, 
                        resource.dob,                        
                        resource.city,
                        resource.state_id,
                        resource.zip_code,
                        resource.ethnicity_id
                      ]
    mandatory_fields_missing = false
    mandatory_fields.each do |field|
      mandatory_fields_missing = mandatory_fields_missing || check_field(field)
    end

    if mandatory_fields_missing      
        edit_user_path(resource)
    elsif request.referer == sign_in_url      
      super
    else
      stored_location_for(resource) || request.referer || root_path      
    end
  end

  def check_field(field)
    return field==nil || field==""    
  end

  def age(birthday)
    # now = Time.now.utc.to_date
    if birthday.present?
      a = birthday      
      b = a.split("-")[2] << "-" << a.split("-")[0] << "-" << a.split("-")[1]
      birthday_date = Date.parse(b)
      return b, (Date.today - birthday_date).to_i / 365
      # now.year - birthday.to_date.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
    else
      nil
    end
  end

  def check_for_pending_requests
    unless current_user.nil?
      @friends_request = UserFriend.received_requests(current_user.id)
    end
  end
  
end
