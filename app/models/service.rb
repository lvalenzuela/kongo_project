class Service < ActiveRecord::Base
	has_many :contractors, through: :contractor_services
	validates :name, :description, :presence => true
end
