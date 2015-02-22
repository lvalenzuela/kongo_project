class Worker < ActiveRecord::Base
	has_many :contractors, through: :contractor_workers
	has_many :worker_documents
	validates :firstname, :lastname1, :rut, :gender, :presence => true
	validates :rut, :uniqueness => true
end
