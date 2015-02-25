class EmployeeDocument < ActiveRecord::Base	
	has_one :employee
	has_one :file_category
	has_attached_file :file
	validates_attachment :file, :content_type => {:content_type => "application/pdf"}
	validates_attachment :file, :presence => true
	validates :filename, :employee_id, :file_category_id, :presence => true
end
