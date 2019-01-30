class UsersController < ApplicationController
  #verificado###
  def showUsers
    @users=User.all
    render json: @users 
  end
  def create
    #verificado###
    @user=User.new(user_params)
    @user.password_hash = user_params[:password]
  	if @user.save
  	      render_error("usuario creado",:created)
  	else
  	  render json: @user.errors, status: :unprocessable_entity
  	end
  end
  
  #verificado###
  def session
    @user = User.find_by_username(user_params[:username])
    if @user and @user.valida_password(user_params[:password])
         @user.token=@user.generate_token
        if @user.save
            render json:@user,status: :ok
        else
            render json: @user.errors, status: :unprocessable_entity
        end
      else
        render_error("usuario o contraseña incorrecta",422)
      end
  end
  

  private 
  def user_params
    params.permit(:username,:password,:screen_name,:email)     
  end
  
end