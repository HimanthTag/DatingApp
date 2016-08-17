module MessagesHelper
  def recipients_options(current_user_id,uid)
    s = ''
    UserFriend.accepted_friends(current_user_id).each do |user_friend|
    	user = user_friend.user
    	if uid == user.id
      		s << "<option value='#{user.id}' selected='selected' data-img-src='#{gravatar_image_url(user.email, size: 50)}'>#{user.first_name}</option>"
      	else
      		s << "<option value='#{user.id}' data-img-src='#{gravatar_image_url(user.email, size: 50)}'>#{user.first_name}</option>"
      	end
    end
    s.html_safe
  end
end