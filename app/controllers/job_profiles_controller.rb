class JobProfilesController < ApplicationController
	before_filter :set_current_user

	def index
		@job_profile = JobProfile.all()
	end

	def new
		@job_profile = JobProfile.new()
	end

	def create
		@job_profile = JobProfile.create(job_profile_params)
		if @job_profile.valid?
			redirect_to :action => :index
		else
			render :new
		end
	end

	private

	def job_profile_params
		params.require(:job_profile).permit(:name, :description)
	end

	def set_current_user
		@current_user = current_user
	end
end
