module CommonLib

	def example_file(filename)
		return Rails.root.join("app","assets","file_examples",filename)
	end
end