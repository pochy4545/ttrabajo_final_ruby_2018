class ApplicationController < ActionController::API
  
def user_for_token
  return if request.headers["X-QA-Key"].blank?
  User.by_token(request.headers["X-QA-Key"])

end

def render_error(mensaje,status)
   render json: {:mensaje => mensaje},status: status
end

      
end
