class CreateUserRoles < ActiveRecord::Migration
  def up
    create_table :user_roles do |t|
    	t.string :name
    	t.string :description
    	t.integer :role_hierarchy
		t.timestamps
    end
    #se incluye la columna en la tabla de usuarios
    add_column :users, :role_id, :integer, :after => :email
    #roles predeterminados
    UserRole.create(:name => "System Administrator", :description => "Administrador Global del Sistema", :role_hierarchy => 1)
    UserRole.create(:name => "Manager", :description => "Administrador del Sistema", :role_hierarchy => 2)
    UserRole.create(:name => "Administrative", :description => "Administrativo", :role_hierarchy => 3)
    UserRole.create(:name => "Contractor", :description => "Contratista", :role_hierarchy => 4)
    UserRole.create(:name => "Guest", :description => "Invitado", :role_hierarchy => 5)
  end

  def down
  	drop_table :user_roles
  	remove_column :users, :role_id
  end
end
