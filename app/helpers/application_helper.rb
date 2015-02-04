module ApplicationHelper
	
	def activate_menu_item(desired,active)
		if active.include?(desired)
			return "active"
		end
	end
end
