class ContractorService < ActiveRecord::Base
	validates :service_id, :contractor_id, :service_start_date, :service_end_date, :presence => true
	validate :end_date_must_be_greater_than_start_date

	def end_date_must_be_greater_than_start_date
		if service_end_date <= service_start_date
			errors.add(:service_end_date, "Start Date can't be greater than End Date.")
		end
	end
end
