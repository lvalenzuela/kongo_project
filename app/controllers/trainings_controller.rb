class TrainingsController < ApplicationController
	before_filter :check_authentication
	before_filter :set_current_user

	def index
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
		params.require(:training).permit(:name, :validity_period)
	end
end
