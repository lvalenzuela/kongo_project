class WorkersController < ApplicationController
	before_filter :set_current_user

	def index
		@workers = Worker.all()
	end

	def search
		@workers = Worker.where("firstname like ?
								or lastname1 like ?
								or lastname2 like ?
								or email like ?
								or rut like ?",
								params[:name].blank? ? nil : "%#{params[:name]}%",
								params[:lastname].blank? ? nil : "%#{params[:lastname]}%",
								params[:lastname].blank? ? nil : "%#{params[:lastname]}%",
								params[:email].blank? ? nil : "%#{params[:email]}%",
								params[:rut].blank? ? nil : "%#{params[:rut]}%")
		render :index
	end

	def new
		@worker = Worker.new()
		@contractors = Contractor.all()
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
