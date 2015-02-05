class ContractorsController < ApplicationController	
	before_filter :set_current_user
	require "csv"

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
		send_file Rails.root.join("app","assets","file_examples","workers_list.csv")
	end

	def bulk_create_workers
		begin
			file_contents = params[:workers_file].read
			csv_workers = CSV.parse(file_contents, :headers => true)
			counter = 0
			csv_workers.each do |row|
				wk = Worker.new()
				wk.rut = row["Rut"]
				wk.firstname = row["Nombre"]
				wk.lastname1 = row["Apellido Paterno"]
				wk.lastname2 = row["Apellido Materno"]
				wk.contractor_id = params[:contractor_id]
				wk.gender = row["Genero"]
				wk.save!
				counter +=1
			end
			flash[:notice] = "Se han creado #{counter} nuevos trabajadores"
		rescue => error
			puts error.inspect
			flash[:notice] = "Ocurrió un error al leer el archivo indicado. Por favor, revisa el archivo de ejemplo y vuelve a intentarlo."
		ensure
			redirect_to :action => :bulk_new_workers, :id => params[:contractor_id]
		end
	end

	private

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
