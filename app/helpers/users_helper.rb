module UsersHelper
	def profile_heading(user_id)
		if current_user.id == user_id.to_i
			"MY PROFILE"
		else
			"PROFILE INFO"
		end
	end
end
