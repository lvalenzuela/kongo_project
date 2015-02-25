class ContractorEmployee < ActiveRecord::Base
	validates :contractor_id, :employee_id, :enabled, :presence => true
	validate :contractor_employee_replication, :on => :create

	def contractor_employee_replication
		if ContractorEmployee.exists?(:contractor_id => contractor_id, :employee_id => employee_id)
			errors.add(:contractor_id, "Already exists for this employee.")
		end
	end
end
