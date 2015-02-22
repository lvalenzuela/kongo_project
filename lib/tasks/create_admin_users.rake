namespace :user do
  desc "Creates System Admin Users."
  task :create_admin_users => :environment do
  	admin = User.where(:username => "admin")
  	if admin.blank?
  		new_admin = User.new()
  		new_admin.firstname = "System"
  		new_admin.lastname = "Admin"
  		new_admin.role_id = 1
  		new_admin.email = "admin@kongo.cl"
  		new_admin.idnumber = "1"
  		new_admin.password = "admin"
  		new_admin.lang = "es"
  		new_admin.save!	
  	end
  end
end