class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_action :set_locale

	def set_locale
		I18n.locale = current_user.lang || params[:locale] || I18n.default_locale
	end

	def default_url_options(options = {})
  		{ locale: I18n.locale }.merge options
	end

	def current_user
		@current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
	end

	def check_authentication
	    if current_user.nil?
	      redirect_to :controller => :users, :action => :user_login
	    end
	end
end
