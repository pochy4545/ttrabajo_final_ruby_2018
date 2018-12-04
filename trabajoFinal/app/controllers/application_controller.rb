class ApplicationController < ActionController::API

def render_error(mensaje,status)
   render json: {:mensaje => mensaje},status: status
end

      
end
