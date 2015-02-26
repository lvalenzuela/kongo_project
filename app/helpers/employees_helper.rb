module EmployeesHelper

	def active_employee_contractor(employee_id)
		c = ContractorEmployee.where(:employee_id => employee_id, :enabled => true).first()
		if c.blank?
			return "-"
		else
			return Contractor.find(c.contractor_id).business_name
		end
	end

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
