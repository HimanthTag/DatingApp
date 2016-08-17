module ApplicationHelper

def gravatar_for(user, size = 30, title = user.first_name)
	image_tag gravatar_image_url(user.email, :size => size,:default => user.fb_image ? user.fb_image : "") ,title: title, class: 'img-rounded'
end

def page_header(text)
  content_for(:page_header) { text.to_s }
end

def sender_name(conversation)
	conversation.receipts_for(current_user).first.message.sender.full_name
end

def read_more(text,length)
	truncate(text, :length => length)
end

def my_height
    [["4' 6\"",4.6],["4' 7\"",4.7],["4' 8\"",4.8],["4' 9\"",4.9],["4' 10\"",4.10],["4' 11\"",4.11],["5' 0\"",5.0],["5' 1\"",5.1],["5' 2\"",5.2],["5' 3\"",5.3],["5' 4\"",5.4],["5' 5\"",5.5],["5' 6\"",5.6],["5' 7\"",5.7],["5' 8\"",5.8],["5' 9\"",5.9],["5' 10\"",5.10],["5' 11\"",5.11],["6' 0\"",6.0],["6' 1\"",6.1],["6' 2\"",6.2],["6' 3\"",6.3],["6' 4\"",6.4],["6' 5\"",6.5],["6' 6\"",6.6],["6' 7\"",6.7],["6' 8\"",6.8],["6' 9\"",6.9],["6' 10\"",6.10],["6' 11\"",6.11],["7' 0\"",7.0],["7' 1\"",7.1],["7' 2\"",7.2],["7' 3\"",7.3],["7' 4\"",7.4],["7' 5\"",7.5],["7' 6\"",7.6],["7' 7\"",7.7],["7' 8\"",7.8]]
end

def my_body_type
	[["Slim","Slim"],["Athletic","Athletic"], ["Average","Average"], ["Muscular","Muscular"],["Heavy","Heavy"]]
end

def age_group
	[["18+", "1"],["18-20", "2"],["21-25","3"],["26-30","4"],["31-35","5"],["36-40","6"],["41+","7"]]
end



end
