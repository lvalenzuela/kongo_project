class Training < ActiveRecord::Base
	has_many :training_courses
	has_many :job_profiles, through: :job_profile_trainings
end
