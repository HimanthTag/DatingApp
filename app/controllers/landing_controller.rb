class LandingController < ApplicationController
	before_filter :authenticate_user!, :except=>[:privacy]

	def index
		@q = User.ransack(params[:q])
    	@res = @q.result.includes(:interests, :groups)
		# @accepted_friends, @friends_request = UserFriend.friends_and_requests(current_user.id)		
		@accepted_friends = UserFriend.accepted_friends(current_user.id)
		@sent_requests = UserFriend.sent_requests(current_user.id)
	end

	def privacy
	end
end
