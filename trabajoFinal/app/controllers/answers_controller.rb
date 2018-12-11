class AnswersController < ApplicationController
 #rails recue from   
  def show
  @quest=Question.find(params[:question_id])
  render json: @quest.answers
 end
 #mirar
 def create
  @quest=Question.find_by(params[:question_id])
  if user_for_token
      @respuesta=Answer.new(answer_params)
      @respuesta.user_id = user_for_token().id
      @respuesta.question_id = @quest.id 
      if @respuesta.save
          render_error("se creeo la respuesta correctamente", :created)
      else
          render json: @respuesta.errors, status: :unprocessable_entity
      end
  else
    render_error("genere un nuevo token,token invalido o inexistente",:unprocessable_entity)
  end
 end
 #mirar
 def destroy
  @quest=Question.find(params[:question_id])
  @answer=@quest.answers.find_by!(id: params[:id], user:user_for_token)
  if @answer.destroy
      render json: {:mensaje => "respuesta eliminada"},status:200
  else
     render json: @answer.errors , status: :unprocessable_entity
  end  
 end

 private
 def answer_params
  params.permit(:content)
 end
end
