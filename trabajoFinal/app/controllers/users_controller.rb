class UsersController < ApplicationController
  def showUsers
    users=User.all
    render json: users 
  end
  def create
  	@user = User.new(user_params)
  	    if @user.save

  	      render json: {:mensaje => "usuario creado"},status: :created
  	    else
  	      render json: @user.errors, status: :unprocessable_entity
  	    end
  end

  def session
 
  end
  
  private
   
  def user_params
      params.require(:user).permit(:username,:password,:screen_name,:email)
  end
  
end