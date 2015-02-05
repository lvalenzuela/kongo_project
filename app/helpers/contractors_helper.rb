module ContractorsHelper
	def contractor_status(id)
		status = ContractorStatus.find(id)
		if status.blank?
			return "-"
		else
			return status.name
		end
	end
end
