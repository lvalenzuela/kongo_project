class User < ActiveRecord::Base
	has_one :user_role
	validates_confirmation_of :password, :email
	validates :firstname, :lastname, :email, :idnumber, :role_id, :password, :presence => true
	validates :email, :idnumber, :uniqueness => true
	before_create :creation_defaults

	def read_password
		@password ||= BCrypt::Password.new(password)
	end

	def update_defaults
		name = firstname+" "+lastname
	end

	def creation_defaults
		self.name = self.firstname+" "+self.lastname
		self.username = self.email
		self.password = BCrypt::Password.create(self.password)
		if lang.blank?
			lang = "es"
		end
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