module WorkersHelper

	def contractor_name(id)
		contractor = Contractor.find(id)
		if contractor.blank?
			return "-"
		else
			return contractor.commercial_name
		end
	end
end
