class UsersController < ApplicationController
	layout :resolve_layout
	before_filter :check_authentication, :except => [:user_login, :login]
	before_filter :set_current_user

	def index
		@users = User.all()
	end

	def user_login

	end

	def login
		user = User.find_by_username(params[:username])
		if user.blank?
			flash[:notice] = "El nombre de usuario es incorrecto. Por favor intentelo de nuevo."
			redirect_to :action => :user_login
		elsif BCrypt::Password.new(user.password) == params[:password] #el nombre de usuario existe
			if params[:remember_me]
				cookies.permanent[:auth_token] = User.find(user.id).check_auth_token
			else
				cookies[:auth_token] = User.find(user.id).check_auth_token
			end
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
