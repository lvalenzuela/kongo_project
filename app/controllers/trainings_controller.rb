class TrainingsController < ApplicationController
	before_filter :check_authentication
	before_filter :set_current_user

	def index
		@trainings = Training.all()
	end

	def search 
		@trainings = Training.where("name like ?
									or validity_period = ?",
									params[:name].blank? ? nil : "%#{params[:name]}%",
									params[:validity_period].blank? ? nil : params[:validity_period])
		render :index
	end

	def new
		@training = Training.new()
	end

	def create
		@training = Training.create(training_params)
		if @training.valid?
			redirect_to :action => :index
		else
			render :new
		end
	end

	private

	def set_current_user
		@current_user = current_user
	end

	def training_params
		params.require(:training).permit(:name, :description, :validity_period)
	end
end
