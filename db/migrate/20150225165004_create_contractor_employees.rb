class CreateContractorEmployees < ActiveRecord::Migration
  def up
    create_table :contractor_employees do |t|
    	t.integer :contractor_id
    	t.integer :employee_id
    	t.boolean :enabled
		t.timestamps
    end
  end

  def down
  	drop_table :contractor_employees
  end
end
