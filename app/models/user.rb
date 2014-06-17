class User < ActiveRecord::Base
	
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	validates :name, presence:   true, length: { maximum: 50 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence:  true, format: { with: VALID_EMAIL_REGEX },
				uniqueness: { case_sensitive: false }
	
	validates :phone, length: { minimum:10 }
	
	validates :membership, presence: true


	validates :password, length: {minimum: 8}
	has_secure_password

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	private

		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end