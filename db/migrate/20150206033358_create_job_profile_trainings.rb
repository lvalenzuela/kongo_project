class CreateJobProfileTrainings < ActiveRecord::Migration
  def up
    create_table :job_profile_trainings do |t|
    	t.integer :job_profile_id
    	t.integer :training_id
		t.timestamps
    end
  end

  def down
  	drop_table :job_profile_trainings
  end
end
