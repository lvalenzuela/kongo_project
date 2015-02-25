module EmployeesHelper
	def contractor_name(id)
		contractor = Contractor.find(id)
		if contractor.blank?
			return "-"
		else
			return contractor.commercial_name
		end
	end

	def document_category(id)
		if id.blank?
			return "-"
		else
			return FileCategory.find(id).name
		end
	end
end
