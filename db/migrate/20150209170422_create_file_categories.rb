class CreateFileCategories < ActiveRecord::Migration
  def up
    create_table :file_categories do |t|
    	t.string :name
    	t.string :description
		t.timestamps
    end
    FileCategory.create(:name => "Contrato de Trabajo", :description => "Contrato de trabajo del trabajador.")
    FileCategory.create(:name => "Examen Médico", :description => "Examen médico del trabajador.")
    FileCategory.create(:name => "Certificado de Capacitacion", :description => "Certificado de Capacitación del Trabajador.")
  end

  def down
  	drop_table :file_categories
  end
end
