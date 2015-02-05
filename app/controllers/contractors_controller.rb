class ContractorsController < ApplicationController	
	before_filter :set_current_user

	def index
		@contractors = Contractor.all()
	end

	def new
		@contractor = Contractor.new()
	end

	def create
		@contractor = Contractor.create(contractor_params)
		if @contractor.valid?
			redirect_to :action => :index
		else
			render :new
		end
	end

	def edit
		@contractor = Contractor.find(params[:id])
		@contractor_statuses = ContractorStatus.all()
	end

	def update
		@contractor = Contractor.find(params[:id])
		@contractor.update_attributes(contractor_params)
		if @contractor.valid?
			redirect_to :action => :show, :id => @contractor.id
		else
			render :edit
		end
	end

	def show
		@contractor = Contractor.find(params[:id])
	end

	private

	def contractor_params
		params.require(:contractor).permit(:commercial_name, :business_name, :email, :rut, :temporality, :status_id, :observations, :address, :region, :comuna, :country)
	end

	def set_current_user
		@current_user = current_user
	end
end
