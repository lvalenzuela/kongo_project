class Worker < ActiveRecord::Base
	has_one :contractor
	validates :firstname, :lastname1, :rut, :contractor_id, :gender, :presence => true
	validates :rut, :uniqueness => true
end
