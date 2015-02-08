class ServicesController < ApplicationController	
	before_filter :set_current_user

	def index
		@services = Service.all()
	end

	def search
		@services = Service.where("name like ?", params[:name].blank? ? nil : "%#{params[:name]}%")
		render :index
	end

	def new
		@service = Service.new()
	end

	def create
		@service = Service.create(service_params)
		if @service.valid?
			redirect_to :action => :index
		else
			render :new
		end
	end

	private

	def service_params
		params.require(:service).permit(:name, :description)
	end

	def set_current_user
		@current_user = current_user
	end
end
