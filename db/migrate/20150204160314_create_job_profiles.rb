class CreateJobProfiles < ActiveRecord::Migration
  def up
    create_table :job_profiles do |t|
    	t.string :name
    	t.string :description
		t.timestamps
    end
  end

  def down
  	drop_table :job_profiles
  end
end
