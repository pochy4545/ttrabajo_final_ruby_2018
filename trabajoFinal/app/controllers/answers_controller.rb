class AnswersController < ApplicationController
  
  def show
  @quest=Question.find(params[:question_id])
  render json: @quest.answers
 end
 
 def create
  @quest=Question.find_by(params[:question_id])
  if user_for_token
     if (!@quest.status)
        render_error("la pregunta ya esta resuelta",:unprocessable_entity)
     else
      #respuesta=@quest.answers.new()
      @respuesta=Answer.new()
      @respuesta.content = answer_params[:content]
      @respuesta.user_id = user_for_token().id
      @respuesta.question_id = @quest.id 
      if @respuesta.save
          render_error("se creeo la respuesta correctamente", :created)
      else
          render json: @respuesta.errors, status: :unprocessable_entity
      end
     end    
  else
    render_error("genere un nuevo token,token invalido o inexistente",:unprocessable_entity)
  end
 end
 
 def destroy
  @quest=Question.find(params[:question_id])
  @answer=@quest.answers.find_by!(id: params[:id], user:user_for_token )
  if @answer.destroy
      render json: {:mensaje => "respuesta eliminada"},status:200
  else
     render json: @answers.errors , status: :unprocessable_entity
  end  
 end

 private
 def answer_params
  params.permit(:content)
 end
end
