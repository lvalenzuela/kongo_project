class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
    	t.string :username
    	t.string :password
    	t.string :idnumber #rut
    	t.string :firstname
    	t.string :lastname
    	t.string :name
    	t.string :email
    	t.string :phone1
    	t.string :phone2
    	t.string :auth_token
    	t.string :company_name 
    	t.string :department
    	t.string :address
    	t.string :city
    	t.integer :lang_id
    	t.date :first_access
    	t.date :last_access
    	t.text :description
    	t.boolean :confirmed
    	t.boolean :deleted
    	t.boolean :suspended
		t.timestamps
    end
  end

  def down
  	drop_table :users
  end
end
