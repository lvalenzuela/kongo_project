class Service < ActiveRecord::Base
	validates :name, :description, :presence => true
end
