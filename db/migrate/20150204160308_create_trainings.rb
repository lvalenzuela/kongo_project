class CreateTrainings < ActiveRecord::Migration
  def up
    create_table :trainings do |t|
    	t.string :name
    	t.string :description
    	t.integer :validity_period
		t.timestamps
    end
  end

  def down
  	drop_table :trainings
  end
end
