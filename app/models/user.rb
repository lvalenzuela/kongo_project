class User < ActiveRecord::Base
	validates_confirmation_of :password, :email
	validates :firstname, :lastname, :email, :password, :presence => true
	before_create :generate_defaults

	def generate_defaults
		self.name = self.firstname+" "+self.lastname
		self.username = self.email
		self.password = BCrypt::Password.create(self.password)
	end

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	def check_auth_token
		if self.auth_token.nil?
			generate_token(:auth_token)
			save!
		end
		return self.auth_token
	end
end