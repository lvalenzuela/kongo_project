class CreateContractors < ActiveRecord::Migration
  def up
    create_table :contractors do |t|
    	t.string :commercial_name
    	t.string :business_name
    	t.string :rut
      t.string :email
    	t.string :temporality
    	t.integer :status_id
    	t.integer :services_amt
    	t.integer :workers_amt
    	t.string :observations
    	t.string :address
    	t.integer :region
    	t.integer :comuna
    	t.integer :country
		t.timestamps
    end
  end

  def down
  	drop_table :contractors
  end
end
