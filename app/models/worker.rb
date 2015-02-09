class Worker < ActiveRecord::Base
	has_one :contractor
	has_many :worker_documents
	validates :firstname, :lastname1, :rut, :contractor_id, :gender, :presence => true
	validates :rut, :uniqueness => true
end
