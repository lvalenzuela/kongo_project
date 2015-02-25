class CreateEmployeeDocuments < ActiveRecord::Migration
  def up
    create_table :employee_documents do |t|
    	t.integer :employee_id
      	t.integer :file_category_id
    	t.string :filename
    	t.attachment :file
		t.timestamps
    end
  end

  def down
  	drop_table :employee_documents
  end
end
