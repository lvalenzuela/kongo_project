class EmployeesController < ApplicationController
	before_filter :set_current_user

	include EmployeesLib
	include CommonLib

	require "csv"

	def index
		@employees = Employee.all()
	end

	def search
		@employees = Employee.where("firstname like ?
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
		@employee = Employee.find(params[:id])
		@documents = EmployeeDocument.where(:employee_id => params[:id])
		@contractors = ContractorEmployee.where(:employee_id => params[:id])
	end

	def edit_contractors
		@employee = Employee.find(params[:id])
		@employee_contractors = ContractorEmployee.where(:employee_id => params[:id])
		@contractors_list = Contractor.all()
		@contractor_employee = ContractorEmployee.new()
	end

	def save_active_contractor
		#marcar todos como desabilitados
		contractors = ContractorEmployee.where(:employee_id => params[:employee_id])
		contractors.each do |c|
			c.enabled = 0 #false
			c.save!
		end
		#habilitar el que corresponde
		contractor_employee = ContractorEmployee.find(params[:enabled_contractor])
		contractor_employee.enabled = 1 #true
		contractor_employee.save!
		redirect_to :action => :edit_contractors, :id => params[:employee_id]
	end

	def destroy_contractor
		ContractorEmployee.where(:employee_id => params[:employee_id], :contractor_id => params[:contractor_id]).destroy_all
		redirect_to :action => :edit_contractors, :id => params[:employee_id]
	end

	def create_contractor_employee
		@contractor_employee = ContractorEmployee.create(contractor_employee_params)
		if @contractor_employee.valid?
			redirect_to :action => :edit_contractors, :id => @contractor_employee.employee_id
		else
			@employee = Employee.find(params[:contractor_employee][:employee_id])
			@employee_contractors = ContractorEmployee.where(:employee_id => @employee.id)
			@contractors_list = Contractor.all()
			render :edit_contractors
		end
	end

	def new_document
		@employee = Employee.find(params[:id])
		@categories = FileCategory.all()
		@document = EmployeeDocument.new()
	end

	def create_document
		@document = EmployeeDocument.create(employee_document_params)
		if @document.valid?
			redirect_to :action => :show, :id => @document.employee_id
		else
			@employee = Employee.find(@document.employee_id)
			@categories = FileCategory.all()
			render :new_document
		end
	end

	def new
		@employee = Employee.new()
		@contractors = Contractor.all()
	end

	def create
		@employee = Employee.create(employee_params)
		if @employee.valid?
			if params[:contractor_id]
				#Bind Employee to Contractor
				ContractorEmployee.create(:contractor_id => params[:contractor_id], :employee_id => @employee.id, :enabled => true)
			end
			redirect_to :action => :index
		else
			@contractors = Contractor.all()
			render :new
		end
	end

	def edit
		@employee = Employee.find(params[:id])
	end

	def update
		@employee = Employee.find(params[:id])
		@employee.update_attributes(employee_params)
		if @employee.valid?
			redirect_to :action => :show, :id => @employee.id
		else
			render :edit
		end
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
			@file = params[:employees_file]
			file_contents = @file.read
			csv_employees = CSV.parse(file_contents)
			@file_headers = csv_employees.first()
			@contractor = Contractor.find(params[:contractor_id])
		rescue => error
			puts error.inspect
			flash[:notice] = "Ocurrió un error al leer el archivo indicado. Por favor, revisa el archivo de ejemplo y vuelve a intentarlo."
			#se vuelve a solicitar el archivo
			redirect_to :action => :bulk_new, :contractor_id => params[:contractor_id]
		ensure
		end
	end

	def bulk_create
		created_employees = bulk_employees_from_file(params[:employees_file_path],params[:file_column], params[:contractor_id])
		if created_employees == -1
			flash[:notice] = "Ocurrió un error al leer el archivo indicado. Por favor, revisa el archivo de ejemplo y vuelve a intentarlo."
		else
			flash[:notice] = "Se han creado #{created_employees} nuevos trabajadores"
		end
		redirect_to :action => :bulk_new, :contractor_id => params[:contractor_id]
	end

	private

	def contractor_employee_params
		params.require(:contractor_employee).permit(:employee_id, :contractor_id)
	end

	def employee_document_params
		params.require(:employee_document).permit(:employee_id, :file_category_id, :filename, :file)
	end

	def employee_params
		params.require(:employee).permit(:firstname, 
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
