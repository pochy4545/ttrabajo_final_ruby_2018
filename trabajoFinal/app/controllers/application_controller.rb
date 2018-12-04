class ApplicationController < ActionController::API
#before_action :validate_login

def validate_type_users
    if params['data'] && params['data']['type']
      if params['data']['type'] == "users"
        return true
      end
    end
    head :conflict and return
end
def validate_type_questions
	    if params['data'] && params['data']['type']
	      if params['data']['type'] == "questions"
	        return true
	      end
	    end
	    head :conflict and return
end
def validateExistencia_token(token)
	user=User.find_by token:token
    if user
    	return true
    else
    	return false
    end
end
def id_for_token(token)
	user=User.find_by_token(token)
	return user.id
end

def refresh_token
 if !request.headers["X-QA-Key"].blank?
 token = request.headers["X-QA-Key"]
 user = User.find_by token: token
 if user
 if 30.minutes.ago < user.updated_at
  user.touch
  else
    #no se si es lo mejor ,le genero uno nuevo internamente?
    user.token= false
    user.save
  end
 end
end
end

def render_error(mensaje,status)
   render json: {:mensaje => mensaje},status: status
end

      
end
