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
        render_error("no existe la pregunta.",422)
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
           render_error("preguta creada",:created)
        else
          render json: @question.errors, status: :unprocessable_entity
        end
    else
      render_error("genere un nuevo token,token invalido o inexistente",422)
    end
  else
    render_error("no se recivio token ",422)
  end
 end

 def update
    @quest=Question.find_by_id(params[:id])
    if @quest
       # render json: @quest
    else
        render_error("no existe la pregunta a actualizar",422)
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
                      render_error("la pregunta tiene respuestas",422)
                   else
                      @quest.destroy
                      render_error("se elimino la pregunta conrrestamente",200)
                  end
              else
                render_error("no tiene previlegios para borrar la pregunta",422)
              end
          else
              render_error("no existe la pregunta",422)
          end
      else
        render_error("genere un nuevo token,token invalido o inexistente",422)
      end
    else
       render_error("no se recivio token ",422)
    end

 end

 def dameRespuestas
  @quest=Question.find_by_id(params[:question_id])
  if @quest
     render json: @quest.answers
  else
      render_error("no existe la pregunta de la cual se requieren respuestas",422)
  end
 end
 
 def crearRespuesta
  @quest=Question.find_by_id(params[:question_id])
  if @quest
      @user=User.new()
      if (!question_params[:token].blank?)
       if @user.existeUser(question_params[:token])
          if (!@quest.status)
              render_error("la pregunta ya esta resuelta",422)
          else
            if (!question_params[:content].blank?)
              #respuesta=@quest.answers.new()
              @respuesta=Answer.new()
              @respuesta.content=question_params[:content]
              @respuesta.user_id = @user.dameid(question_params[:token])
              @respuesta.question_id = @quest.id 

               if @respuesta.save
                  render_error("se creeo la respuesta correctamente",201)
               else
                 render json: @respuesta.errors, status: :unprocessable_entity
               end
            else
              render_error("content vacio",422)
            end
           end    
       else
         render_error("genere un nuevo token,token invalido o inexistente",422)
       end
     else
        render_error("no se recivio token ",422)
     end
  else
      render_error("no existe la pregunta a la cual se quiere responder",422)
  end
end
 
 def eliminarRespuesta
  @quest=Question.find_by_id(params[:question_id])
  if @quest
    @answer=Answer.find_by_id(params[:id])
    if @answer
       if @answer.question_id == @question.id
         @user=User.new()
          if (!question_params[:token].blank?)
             if @user.existeUser(question_params[:token])
               if  @answer.user_id==@user.dameid(question_params[:token])
             #     @answer.destroy
             #    render json: {:mensaje => "respuesta eliminada"},status:200
               else
                 render_error("no tiene previlegios para borrar la respuesta",422)
               end
             else
               render_error("token invalido o inexistente",422)
             end 
          else
            render_error("no se recivio token ",422)
          end
       else
          render_error("la respuesta no esta asociada a la pregunta",422)
       end
    else
     render_error("no existe la respuesta",422)
    end
  else
      render_error("no existe la pregunta ",422)
  end  
 end

 def respuestaCorrecta
 end

 def question_params
    params.require(:question).permit(:title,:description,:status,:sort,:token,:id,:content)
 end

end