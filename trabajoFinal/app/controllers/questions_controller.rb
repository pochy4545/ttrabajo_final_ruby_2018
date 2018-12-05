class QuestionsController < ApplicationController
  #before_action :validate_type_questions
  before_action :refresh_token , only: [:create,:delete,:crearRespuesta,:eliminarRespuesta,]
 def showall
    questions=Question.limit(50)
    if (!question_params[:sort].blank?)
      @result= case question_params[:sort]
       when "latest" then @result = questions.order(created_at: :asc)
       when "pending_first"then @result = questions.order()
       when "needing_help"then @result = questions.order()
       else
       	@result=""
       end	 
    else 
    	@result = questions.order(created_at: :asc)
     end
    render json: @result ,each_serializer: QuestionshowallSerializer
 end

 #compount document???
 def show
    @quest=Question.find_by_id(params[:id])
    if @quest
      if (!question_params[:answer].blank?) 
          render json: @quest, serializer: QuestionandanswershowSerializer
      else
        render json: @quest , serializer: QuestionshowSerializer
      end
    else
        render_error("no existe la pregunta.",:unprocessable_entity)
    end
 end

 def create
    if(!request.headers["X-QA-Key"].blank? )
      if(validateExistencia_token(request.headers["X-QA-Key"]))
        @question=Question.new()
        @question.title = question_params[:title]
        @question.description = question_params[:description]
        @question.user_id = id_for_token(request.headers["X-QA-Key"])
        if @question.save
           render_error("preguta creada",:created)
        else
          render json: @question.errors, status: :unprocessable_entity
        end
    else
      render_error("genere un nuevo token,token invalido o inexistente",:unprocessable_entity)
    end
  else
    render_error("no se recivio token ",:unprocessable_entity)
  end
 end

 def update
    @quest=Question.find_by_id(params[:id])
    if @quest
       # render json: @quest
    else
        render_error("no existe la pregunta a actualizar",:unprocessable_entity)
    end

 end

 def delete
      if (!request.headers["X-QA-Key"].blank?)
      if validateExistencia_token(request.headers["X-QA-Key"])
          @quest=Question.find_by_id(params[:id])
          if @quest
              if  @quest.user_id==id_for_token(request.headers["X-QA-Key"])
                   if @quest.answers.count()>0
                      render_error("la pregunta tiene respuestas",:unprocessable_entity)
                   else
                      @quest.destroy
                      render_error("se elimino la pregunta conrrestamente",:ok)
                  end
              else
                render_error("no tiene previlegios para borrar la pregunta", :unauthorized)
              end
          else
              render_error("no existe la pregunta",:unprocessable_entity)
          end
      else
        render_error("genere un nuevo token,token invalido o inexistente",:unprocessable_entity)
      end
    else
       render_error("no se recivio token ",:unprocessable_entity)
    end

 end

 def dameRespuestas
  @quest=Question.find_by_id(params[:question_id])
  if @quest
     render json: @quest.answers
  else
      render_error("no existe la pregunta de la cual se requieren respuestas",:unprocessable_entity)
  end
 end
 
 def crearRespuesta
  @quest=Question.find_by_id(params[:question_id])
  if @quest
      if (!request.headers["X-QA-Key"].blank?)
       if validateExistencia_token(request.headers["X-QA-Key"])
          if (!@quest.status)
              render_error("la pregunta ya esta resuelta",:unprocessable_entity)
          else
            if (!question_params[:content].blank?)
              #respuesta=@quest.answers.new()
              @respuesta=Answer.new()
              @respuesta.content=question_params[:content]
              @respuesta.user_id = id_for_token(request.headers["X-QA-Key"].blank?)
              @respuesta.question_id = @quest.id 

               if @respuesta.save
                  render_error("se creeo la respuesta correctamente", :created)
               else
                 render json: @respuesta.errors, status: :unprocessable_entity
               end
            else
              render_error("content vacio",:unprocessable_entity)
            end
           end    
       else
         render_error("genere un nuevo token,token invalido o inexistente",:unprocessable_entity)
       end
     else
        render_error("no se recivio token ",:unprocessable_entity)
     end
  else
      render_error("no existe la pregunta a la cual se quiere responder",:unprocessable_entity)
  end
end
 
 def eliminarRespuesta
  @quest=Question.find_by_id(params[:question_id])
  if @quest
    @answer=Answer.find_by_id(params[:id])
    if @answer
       if @answer.question_id == @question.id
          if (!request.headers["X-QA-Key"].blank?)
             if validateExistencia_token(request.headers["X-QA-Key"])
               if  @answer.user_id==id_for_token(request.headers["X-QA-Key"])
             #     @answer.destroy
             #    render json: {:mensaje => "respuesta eliminada"},status:200
               else
                 render_error("no tiene previlegios para borrar la respuesta",:unprocessable_entity)
               end
             else
               render_error("token invalido o inexistente",:unprocessable_entity)
             end 
          else
            render_error("no se recivio token ",:unprocessable_entity)
          end
       else
          render_error("la respuesta no esta asociada a la pregunta",:unprocessable_entity)
       end
    else
     render_error("no existe la respuesta",:unprocessable_entity)
    end
  else
      render_error("no existe la pregunta ",:unprocessable_entity)
  end  
 end

 def respuestaCorrecta
 end

 private
 def question_params
    #params.require(:question).permit(:title,:description,:status,:sort,:token,:id,:content)
  ActiveModelSerializers::Deserialization.jsonapi_parse(params)
 end

end