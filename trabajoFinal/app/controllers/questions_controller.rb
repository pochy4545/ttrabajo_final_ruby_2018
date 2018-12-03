    class QuestionsController < ApplicationController

 def showall
    @questions=Question.all
    #if (!question_params[:sort].blank?)
    #  @result= case question_params[:sort]
    #   when "latest" then @result = @questions.order(created_at: :desc)
    #   when "pending_first"then @result = @result=@questions.order()
    #   when "needing_help"then @result= @result=@questions.order()
    #   else
    #   	@result=""
    #   end	 
    #else 
    #	@result = @questions.order(created_at: :desc)
    # end
    render json: @questions
 end

 def show
    @quest=Question.find_by_id(params[:id])
    if @quest
        render json: @quest
    else
        render json: {:mensaje => "no existe la pregunta"},status: 422
    end
 end

 def create
    @user=User.new()
    if (!question_params[:token].blank?)
    if @user.existeUser(question_params[:token])
        @question=Question.new()
        @question.title = question_params[:title]
        @question.description = question_params[:description]
        @question.user_id = @user.dameid(question_params[:token])
        if @question.save
          render json: {:mensaje => "pregunta creada"},status: :created
        else
          render json: @question.errors, status: :unprocessable_entity
        end
    else
      render json: {:mensaje => "genere un nuevo token,token invalido o inexistente"},status: 422
    end
  else
     render json: {:mensaje => "no se recivio token "},status: 422
  end
 end

 def update
    @quest=Question.find_by_id(params[:id])
    if @quest
       # render json: @quest
    else
        render json: {:mensaje => "no existe la pregunta a actualizar"},status: 422
    end

 end

 def delete
      @user=User.new()
      if (!question_params[:token].blank?)
      if @user.existeUser(question_params[:token])
          @quest=Question.find_by_id(params[:id])
          if @quest
              if  @quest.user_id==@user.dameid(question_params[:token])
                   if @quest.answers.count()>0
                      render json:{:mensaje => "la pregunta tiene respuestas"}
                   else
                      @quest.destroy
                      render json: {:mensaje =>"se elimino la pregunta conrrestamente"},status:200
                  end
              else
                render json: {:mensaje => "no tiene previlegios para borrar la pregunta"},status:422
              end
          else
              render json: {:mensaje => "no existe la pregunta"},status: 422
          end
      else
        render json: {:mensaje => "genere un nuevo token,token invalido o inexistente"},status: 422
      end
    else
       render json: {:mensaje => "no se recivio token "},status: 422
    end

 end

 def dameRespuestas
  @quest=Question.find_by_id(params[:question_id])
  if @quest
     render json: @quest.answers
  else
      render json: {:mensaje => "no existe la pregunta de la cual se requieren respuestas"},status: 422
  end
 end
 
 def crearRespuesta
  @quest=Question.find_by_id(params[:question_id])
  if @quest
      @user=User.new()
      if (!question_params[:token].blank?)
       if @user.existeUser(question_params[:token])
          if (!@quest.status)
              render json: {:mensaje => "la pregunta ya esta resuelta"},status:422
          else
            if (!question_params[:content].blank?)
              @respuesta=Answer.new()
              @respuesta.content=question_params[:content]
              @respuesta.user_id = @user.dameid(question_params[:token])
              @respuesta.question_id = @quest.id 

               if @respuesta.save
                  render json: {:mensaje => "se creeo la respuesta correctamente"},status:201
               else
                 render json: {:mensaje =>"error inesperado al guardar la respuesta intente nuevamente"}
               end
            else
              render json:{:mesnaje => "content vacio"},satus:422
            end
           end    
       else
         render json: {:mensaje => "genere un nuevo token,token invalido o inexistente"},status: 422
       end
     else
        render json: {:mensaje => "no se recivio token "},status: 422
     end
  else
      render json: {:mensaje => "no existe la pregunta a la cual se quiere responder"},status: 422
  end
end

 def until
 end

 def question_params
    params.require(:question).permit(:title,:description,:status,:sort,:token,:id,:content)
 end

end