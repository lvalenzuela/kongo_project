class CreateServices < ActiveRecord::Migration
  def up
    create_table :services do |t|
    	t.string :name
    	t.string :description
		t.timestamps
    end
  end

  def down
  	drop_table :services
  end
end
