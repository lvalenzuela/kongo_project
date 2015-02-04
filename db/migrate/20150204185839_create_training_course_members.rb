class CreateTrainingCourseMembers < ActiveRecord::Migration
  def up
    create_table :training_course_members do |t|
    	t.integer :training_course_id
    	t.integer :worker_id
    	t.decimal :attendance, :precision => 3, :scale => 1
    	t.decimal :grade, :precision => 3, :scale => 1
		t.timestamps
    end
  end

  def down
  	drop_table :training_course_members
  end
end
