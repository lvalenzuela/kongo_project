class Contractor < ActiveRecord::Base
	has_one :contractor_status
	has_many :services, through: :contractor_services
	has_many :workers
	validates :commercial_name, :business_name, :rut, :presence => true
	validates :rut, :uniqueness => true
	before_create :set_defaults

	def set_defaults
		#establecer el estado del contratista como activo al momento de crearlo
		self.country = 1 #pais por defecto, en futuras versiones se incluiran más... espero
		self.status_id = 1 #estado activo
	end
end
