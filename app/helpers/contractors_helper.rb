module ContractorsHelper
	def contractor_status(id)
		status = ContractorStatus.find(id)
		if status.blank?
			return "-"
		else
			return status.name
		end
	end

	def service_name(id)
		service = Service.find(id)
		if service.blank?
			return "-"
		else
			return service.name
		end
	end
end
