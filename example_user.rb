class User
	attr_accessor	:name, :phone, :email
	
	def initialize(attributes = {})
		@name  = attributes[:name]
		@phone = attributes[:phone]
		@email = attributes[:email]
	end
	
	def formatted_user_info
		"#{@name} <#{@phone}> <#{@email}>"
	end
end