class TrainingCourse < ActiveRecord::Base
	has_one :training
	has_many :training_course_members
end
