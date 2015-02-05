class Contractor < ActiveRecord::Base
	has_one :contractor_status
	has_many :services, through: :contractor_services
	has_many :workers
	validates :commercial_name, :business_name, :rut, :presence => true
	before_create :set_defaults

	def set_defaults
		#establecer el estado del contratista como activo al momento de crearlo
		country = 1 #pais por defecto, en futuras versiones se incluiran más... espero
		status_id = 1 #estado activo
	end
end
