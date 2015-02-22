class CreateWorkers < ActiveRecord::Migration
  def up
    create_table :workers do |t|
    	t.string :firstname
    	t.string :lastname1
    	t.string :lastname2
    	t.string :fullname
    	t.string :rut
    	t.date :birthday
    	t.string :gender
    	t.string :address
    	t.integer :region
    	t.integer :comuna
    	t.integer :country
    	t.string :phone
    	t.string :cellphone
    	t.string :email
    	t.string :observations
		t.timestamps
    end
  end

  def down
  	drop_table :workers
  end
end