class ContractorsController < ApplicationController	
	before_filter :set_current_user
	require "csv"

	include WorkersLib
	include CommonLib

	def index
		@contractors = Contractor.all()
	end

	def search
		@contractors = Contractor.where("commercial_name like ?
										or business_name like ?
										or email like ?
										or rut like ?",
										params[:commercial_name].blank? ? nil : "%#{params[:commercial_name]}%",
										params[:business_name].blank? ? nil : "%#{params[:business_name]}%",
										params[:email].blank? ? nil : "%#{params[:email]}%",
										params[:rut].blank? ? nil : "%#{params[:rut]}%")
		render :index
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
		@contractor_services = ContractorService.where(:contractor_id => params[:id])
		@contractor_workers = Worker.where(:contractor_id => params[:id])
	end

	def new_service
		@contractor_service = ContractorService.new()
		@services = Service.all()
		@contractor = Contractor.find(params[:id])
	end

	def bind_service
		@contractor_service = ContractorService.create(contractor_service_params)
		if @contractor_service.valid?
			redirect_to :action => :show, :id => @contractor_service.contractor_id
		else
			@services = Service.all()
			@contractor = Contractor.find(params[:contractor_service][:contractor_id])
			render :new_service
		end
	end

	def new_worker
		@contractor = Contractor.find(params[:id])
	end

	def create_worker

	end

	def bulk_new_workers
		@contractor = Contractor.find(params[:id])
	end

	def workers_file_example
		send_file example_file("workers_list.csv")
	end

	def workers_file_config
		begin
			@file = params[:workers_file]
			file_contents = @file.read
			csv_workers = CSV.parse(file_contents)
			@file_headers = csv_workers.first()
			@contractor = Contractor.find(params[:contractor_id])
		rescue => error
			puts error.inspect
			flash[:notice] = "Ocurrió un error al leer el archivo indicado. Por favor, revisa el archivo de ejemplo y vuelve a intentarlo."
			#se vuelve a solicitar el archivo
			redirect_to :action => :bulk_new_workers, :id => params[:contractor_id]
		ensure
		end
	end

	def bulk_create_workers
		created_workers = bulk_workers_from_file(params[:workers_file_path],params[:file_column], params[:contractor_id])
		if created_workers == -1
			flash[:notice] = "Ocurrió un error al leer el archivo indicado. Por favor, revisa el archivo de ejemplo y vuelve a intentarlo."
		else
			flash[:notice] = "Se han creado #{created_workers} nuevos trabajadores"
		end
		redirect_to :action => :bulk_new_workers, :id => params[:contractor_id]
	end

	private

	def file_column_exists?(row,file_attribute)
		if file_attribute.blank?
			return nil
		else
			return row[file_attribute.to_i]
		end
	end

	def contractor_service_params
		params.require(:contractor_service).permit(:contractor_id, :service_id, :service_start_date, :service_end_date)
	end

	def contractor_params
		params.require(:contractor).permit(:commercial_name, :business_name, :email, :rut, :temporality, :status_id, :observations, :address, :region, :comuna, :country)
	end

	def set_current_user
		@current_user = current_user
	end
end
