class CreateWorkerDocuments < ActiveRecord::Migration
  def up
    create_table :worker_documents do |t|
    	t.integer :worker_id
      t.integer :file_category_id
    	t.string :filename
    	t.attachment :file
		t.timestamps
    end
  end

  def down
  	drop_table :worker_documents
  end
end
