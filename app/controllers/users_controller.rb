class UsersController < ApplicationController
	layout :resolve_layout

	def user_login
	end

	private

	def resolve_layout
		case action_name
		when "user_login"
			return "login_layout"
		else
			return "application"
		end
	end
end
