class UsersController < ApplicationController
before_action :signed_in_user, only: [:edit, :update]
# Only user can edit and update their own profile
before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

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
        sign_in @user
        flash[:success] = "Thank you for joining ZAO"
  			redirect_to @user
  		else
  			render 'new'
  		end
  	end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your profile has been updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find( params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
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

      # Before filters
      # This filter applies to every action in a controller, so we will restrict the filter to 
      # only act on :edit and :update actions by passing the correct :only options hash
      def signed_in_user
        unless signed_in?
          store_location
        redirect_to sign_in_url, notice: "Please sign in." unless signed_in?
        end
      end

      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
      end

      def admin_user
        redirect_to( root_url ) unless current_user.admin?
      end
end
