class WorkersController < ApplicationController
	before_filter :set_current_user

	def index
	end

	def new
		@worker = Worker.new()
	end

	def create
		@worker = Worker.create(worker_params)
	end

	private

	def worker_params
		params.require(:worker).permit(	:firstname, 
										:lastname1, 
										:lastname2, 
										:rut, 
										:birthday, 
										:gender, 
										:address, 
										:region, 
										:comuna, 
										:country, 
										:phone, 
										:cellphone, 
										:email, 
										:observations)
	end

	def set_current_user
		@current_user = current_user
	end
end
