class UsersController < ApplicationController
  def showUsers
    users=User.all
    render json: users 
  end
  def create
  	
  end
  def session
 
  end

  
end