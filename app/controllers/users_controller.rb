class UsersController < ApplicationController
	layout :resolve_layout
	before_filter :check_authentication, :except => [:user_login, :login]
	before_filter :set_current_user

	def index
		@users = User.all()
	end

	def search
		@users = User.where("firstname like ?
							or lastname like ?
							or idnumber like ?",
							params[:name].blank? ? nil : "%#{params[:name]}%",
							params[:lastname].blank? ? nil : "%#{params[:lastname]}%",
							params[:idnumber].blank? ? nil : "%#{params[:idnumber]}%",)
		render :index
	end

	def user_login

	end

	def login
		user = User.find_by_username(params[:username])
		if user.blank?
			flash[:notice] = "El nombre de usuario es incorrecto. Por favor intentelo de nuevo."
			redirect_to :action => :user_login
		elsif user.read_password == params[:password] #el nombre de usuario existe
			if params[:remember_me]
				cookies.permanent[:auth_token] = user.check_auth_token
			else
				cookies[:auth_token] = user.check_auth_token
			end
			if user.first_access.nil?
				#registrar primer login
				user.first_access = Date.today()
			end
			#registrar login
			user.last_access = Date.today()
			user.save!
			redirect_to root_path
		else #la contraseña no es la correcta
			flash[:notice] = "La contraseña ingresada es incorrecta. Por favor intentalo de nuevo."
			redirect_to :action => :user_login
		end
	end

	def logout
		cookies.delete(:auth_token)
		redirect_to :action => :user_login
	end

	def new
		@user = User.new()
		@user_roles = UserRole.all()
	end

	def create
		@user = User.create(user_params)
		if @user.valid?
			flash[:notice] = "El usuario ha sido creado exitosamente."
			redirect_to root_path
		else
			render :new
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
		@user_roles = UserRole.all()
	end

	def update
		@user = User.find(params[:id])
		@user.update_attributes(user_params)
		if @user.valid?
			redirect_to :action => :index
		else
			@user_roles = UserRole.all()
			render :edit
		end
	end

	#edicion de password de current user
	def change_password

	end

	def update_password
		user = current_user
		if user.read_password == params[:old_password]
			if params[:new_password] != params[:new_password_confirm]
				flash[:notice] = "La nueva contraseña no coincide con la confirmación."
				redirect_to :action => :change_password
			elsif params[:new_password].length < 8
				flash[:notice] = "La nueva contraseña debe tener al menos 8 caracteres"
				redirect_to :action => :change_password
			else
				user.password = BCrypt::Password.create(params[:new_password])
				user.save!
				flash[:notice] = "La contraseña fue cambiada con éxito."
				redirect_to :action => :profile
			end
		else
			flash[:notice] = "Contraseña Incorrecta."
			redirect_to :action => :change_password
		end
	end

	private

	def set_current_user
		@current_user = current_user
	end

	def user_params
		params.require(:user).permit(:firstname, :lastname, :email, :idnumber, :role_id, :password)
	end

	def resolve_layout
		case action_name
		when "user_login"
			return "login_layout"
		else
			return "application"
		end
	end
end
