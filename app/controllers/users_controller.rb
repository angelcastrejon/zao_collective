class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

  	def new
  		@user = User.new
  	end

  	def create
  		# User.new( params[:user] ) 
  		# is far too dangerous since it passes all data
  		# submitted by the user
  		# so as of Rails 4 we will work with user_params
  		# this will only be used internally by the User controller
  		# and isn't exposed to external users on the web
  		@user = User.new( user_params )
  		if @user.save
        flash[:success] = "Thank you for joining ZAO"
  			redirect_to @user
  		else
  			render 'new'
  		end
  	end

  	private
  		def user_params
  			params.require(:user).permit(	:name, 
                                      :email,
                                      :phone,
                                      :membership,
                                      :password,
                                      :password_confirmation)
      end
end
