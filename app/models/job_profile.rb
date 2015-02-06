class JobProfile < ActiveRecord::Base
	has_many :trainings, through: :job_profile_trainings
end
