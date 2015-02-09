class WorkersController < ApplicationController
	before_filter :set_current_user

	include WorkersLib
	include CommonLib

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

	def show
		@worker = Worker.find(params[:id])
		@documents = WorkerDocument.where(:worker_id => params[:id])
	end

	def new_document
		@worker = Worker.find(params[:id])
		@categories = FileCategory.all()
		@document = WorkerDocument.new()
	end

	def create_document
		@document = WorkerDocument.create(worker_document_params)
		if @document.valid?
			redirect_to :action => :show, :id => @document.worker_id
		else
			@worker = Worker.find(@document.worker_id)
			@categories = FileCategory.all()
			render :new_document
		end
	end

	def new
		@worker = Worker.new()
		@contractors = Contractor.all()
	end

	def create
		@worker = Worker.create(worker_params)
	end

	def contractor_select
		@contractors = Contractor.all()
	end

	def bulk_new
		@contractor = Contractor.find(params[:contractor_id])
	end

	def example_creation_file
		send_file example_file("workers_list.csv")
	end

	def creation_file_config
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

	def bulk_create
		created_workers = bulk_workers_from_file(params[:workers_file_path],params[:file_column], params[:contractor_id])
		if created_workers == -1
			flash[:notice] = "Ocurrió un error al leer el archivo indicado. Por favor, revisa el archivo de ejemplo y vuelve a intentarlo."
		else
			flash[:notice] = "Se han creado #{created_workers} nuevos trabajadores"
		end
		redirect_to :action => :bulk_new, :contractor_id => params[:contractor_id]
	end

	private

	def worker_document_params
		params.require(:worker_document).permit(:worker_id, :file_category_id, :filename, :file)
	end

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
