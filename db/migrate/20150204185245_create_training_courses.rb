class CreateTrainingCourses < ActiveRecord::Migration
  def up
    create_table :training_courses do |t|
    	t.string :name
    	t.string :course_subject
    	t.integer :speaker_id
    	t.integer :training_id
    	t.date :start_date
      t.date :end_date
      t.boolean :finished
		t.timestamps
    end
  end

  def down
  	drop_table :training_courses
  end
end
