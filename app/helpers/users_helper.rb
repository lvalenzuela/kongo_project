module UsersHelper

	def user_role(id)
		if id
			role = UserRole.find(id)
			if role.blank?
				return "-"
			else
				return role.name
			end
		else
			return "-"
		end
	end
end
