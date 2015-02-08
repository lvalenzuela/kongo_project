class JobProfilesController < ApplicationController
	before_filter :set_current_user

	def index
		@job_profiles = JobProfile.all()
	end

	def search
		@job_profiles = JobProfile.where("name like ?", params[:name].blank? ? nil : "%#{params[:name]}%")
		render :index
	end

	def new
		@job_profile = JobProfile.new()
		@trainings = Training.all()
	end

	def create
		@job_profile = JobProfile.create(job_profile_params)
		if @job_profile.valid?
			#Asociar prerequisitos
			if params[:trainings]
				params[:trainings].each do |t|
					JobProfileTraining.create(:job_profile_id => @job_profile.id, :training_id => t)
				end
			end
			redirect_to :action => :index
		else
			render :new
		end
	end

	def show
		@job_profile = JobProfile.find(params[:id])
		training_list = JobProfileTraining.where(:job_profile_id => @job_profile.id).map{|t| t.training_id}
		@job_profile_trainings = Training.where(:id => training_list)
	end

	def edit_trainings
		@job_profile = JobProfile.find(params[:id])
		@job_profile_trainings = JobProfileTraining.where(:job_profile_id => @job_profile.id).map{|t| t.training_id}
		@trainings = Training.all()
	end

	def save_trainings
		if params[:trainings]
			#Eliminar selecciones anteriores
			JobProfileTraining.where(:job_profile_id => params[:job_profile_id]).delete_all
			params[:trainings].each do |t|
				JobProfileTraining.create(:job_profile_id => params[:job_profile_id], :training_id => t)
			end
		end
		redirect_to :action => :show, :id => params[:job_profile_id]
	end

	private

	def job_profile_params
		params.require(:job_profile).permit(:name, :description)
	end

	def set_current_user
		@current_user = current_user
	end
end
