class Employee < ActiveRecord::Base	
	has_many :contractors, through: :contractor_employees
	has_many :employee_documents
	validates :firstname, :lastname1, :rut, :gender, :presence => true
	validates :rut, :uniqueness => true
end
