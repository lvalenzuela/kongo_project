class ContractorWorker < ActiveRecord::Base
	validates :contractor_id, :worker_id, :enabled, :presence => true
	validate :contractor_worker_replication, :on => :create

	def contractor_worker_replication
		replicated = ContractorWorker.where(:contractor_id => contractor_id, :worker_id => worker_id)
		if !replicated.blank?
			errors.add(:contractor_id, "Already exists for this worker.")
		end
	end
end
