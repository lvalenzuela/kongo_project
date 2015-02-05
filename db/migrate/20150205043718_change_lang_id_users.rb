class ChangeLangIdUsers < ActiveRecord::Migration
  def up
  	change_column :users, :lang_id, :string, :default => "es"
  	rename_column :users, :lang_id, :lang
  end

  def down
  	change_column :users, :lang, :integer
  	rename_column :users, :lang, :lang_id	
  end
end
