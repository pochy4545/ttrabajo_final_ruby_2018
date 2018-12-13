
class ApplicationController < ActionController::API
 rescue_from ActiveRecord::RecordNotFound, :with => :error_render_method

  def error_render_method
  	render_error("not foud",404)
 end
  

def user_for_token
  return if request.headers["X-QA-Key"].blank?
  User.by_token(request.headers["X-QA-Key"])

end

def render_error(mensaje,status)
   render json: {:mensaje => mensaje},status: status
end


   
end
