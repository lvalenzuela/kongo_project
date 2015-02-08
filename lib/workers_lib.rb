module WorkersLib

	def bulk_workers_from_file(file_path, columns_hash, contractor_id)
		begin
			counter = 0
			file_contents = File.read(file_path)
			csv_workers = CSV.parse(file_contents, :headers => true)
			csv_workers.each do |row|
				if !Worker.exists?(:rut => row["Rut"])
					wk = Worker.new()
					wk.firstname = file_column_exists?(row,columns_hash[0])
					wk.lastname1 = file_column_exists?(row,columns_hash[1])
					wk.lastname2 = file_column_exists?(row,columns_hash[2])
					wk.rut = file_column_exists?(row,columns_hash[3])
					wk.birthday = file_column_exists?(row,columns_hash[4])
					wk.gender = file_column_exists?(row,columns_hash[5])
					wk.address = file_column_exists?(row,columns_hash[6])
					wk.region = file_column_exists?(row,columns_hash[7])
					wk.comuna = file_column_exists?(row,columns_hash[8])
					wk.country = file_column_exists?(row,columns_hash[9])
					wk.phone = file_column_exists?(row,columns_hash[10])
					wk.cellphone = file_column_exists?(row,columns_hash[11])
					wk.email = file_column_exists?(row,columns_hash[12])
					wk.observations = file_column_exists?(row,columns_hash[13])
					wk.contractor_id = contractor_id
					wk.save!
					counter +=1
				end
			end
		rescue => error
			puts err.inspect
			#Contador en -1
			#Indica error
			counter = -1
		ensure
			return counter
		end
	end
	
	def file_column_exists?(row,file_attribute)
		if file_attribute.blank?
			return nil
		else
			return row[file_attribute.to_i]
		end
	end
end