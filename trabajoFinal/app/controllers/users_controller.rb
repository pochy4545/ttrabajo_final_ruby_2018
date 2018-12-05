class UsersController < ApplicationController
  before_action :validate_type_users, only: [:create]

  def showUsers
    @users=User.all
    render json: @users 
  end
  def create
  	@user = User.new()
    if ((!@user.existeUsername(user_params[:username]))or (!@user.existeEmail(user_params[:email])))
    @user=User.new(user_params)
    @user.passwordHash = user_params[:password]
  	    if @user.save
  	      render_error("usuario creado",:created)
  	    else
  	      render json: @user.errors, status: :unprocessable_entity
  	    end
    else
      render_error("email o nombre repetido",:unprocessable_entity)
    end
  end

  def session
    @user = User.find_by_username(user_params[:username])
    if @user
      if @user.passworconsulta == user_params[:password]
        @user.token=@user.generate_token
        if @user.save
            render json:@user,status: :ok
        else
            render json: @user.errors, status: :unprocessable_entity
        end
      else
        render_error("usuario o contraseña incorrecta",422)
      end
    else
      render_error("usuario o contraseña incorrecta",422)
    end
  end
  

  private 
  def user_params
     
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
  
end