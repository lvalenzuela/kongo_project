class CreateContractorStatuses < ActiveRecord::Migration
  def up
    create_table :contractor_statuses do |t|
    	t.string :name
    	t.string :description
		t.timestamps
    end
    ContractorStatus.create(:name => "Activo", :description => "Contratista Activo")
    ContractorStatus.create(:name => "Inactivo", :description => "Contratista Inactivo")
    ContractorStatus.create(:name => "Suspendido", :description => "Contratista Suspendido")
  end

  def down
  	drop_table :contractor_statuses
  end
end
