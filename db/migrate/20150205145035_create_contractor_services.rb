class CreateContractorServices < ActiveRecord::Migration
  def up
    create_table :contractor_services do |t|
    	t.integer :contractor_id
    	t.integer :service_id
    	t.date :service_start_date
    	t.date :service_end_date
		t.timestamps
    end
  end

  def down
  	drop_table :contractor_services
  end
end
