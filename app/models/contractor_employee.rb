class ContractorEmployee < ActiveRecord::Base
	validates :contractor_id, :employee_id, :presence => true
	validate :contractor_employee_replication, :on => :create
	before_create :set_defaults

	def set_defaults
		#por defecto se asocian contratistas desabilitados
		#si no se ha especificado que estan habilitados
		enabled ||= 0
	end

	def contractor_employee_replication
		if ContractorEmployee.exists?(:contractor_id => contractor_id, :employee_id => employee_id)
			errors.add(:contractor_id, "Already exists for this employee.")
		end
	end
end
