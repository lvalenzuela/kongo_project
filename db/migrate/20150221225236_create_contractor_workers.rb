class CreateContractorWorkers < ActiveRecord::Migration
  def up
    create_table :contractor_workers do |t|
    	t.integer :contractor_id
    	t.integer :worker_id
    	t.boolean :enabled
		t.timestamps
    end
  end

  def down
  	drop_table :contractor_workers
  end
end
