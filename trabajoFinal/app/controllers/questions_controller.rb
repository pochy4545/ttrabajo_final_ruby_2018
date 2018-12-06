class QuestionsController < ApplicationController
 def showall
    questions=Question.all
    @result = case question_params[:sort]
       when "pending_first"then questions.order(status: :asc).order(created_at: :desc)
       when "needing_help"then questions.where(status: 0).order(created_at: :asc)
       else
       	questions.order(created_at: :desc)
       end	 
   render json: @result.last(50) ,each_serializer: QuestionshowallSerializer
 end
 def show
    @quest=Question.find(params[:id])
    if (!question_params[:answer].blank?) 
          render json: @quest, serializer: QuestionandanswershowSerializer
      else
        render json: @quest , serializer: QuestionshowSerializer
  end
 end

 def create
      if(user_for_token)
        @question=Question.new()
        @question.title = question_params[:title]
        @question.description = question_params[:description]
        @question.user_id = user_for_token
        if @question.save
           render_error("preguta creada",:created)
        else
          render json: @question.errors, status: :unprocessable_entity
        end
      else
        render_error("genere un nuevo token,token invalido o inexistente",:unprocessable_entity)
      end
 end

 def update
    @quest=Question.find_by_id(params[:id])
        if user_for_token
          if  @quest.user_id==user_for_token
            #update
          else
            render_error("no tiene previlegios para actualizr la pregunta", :unauthorized)
          end
        else
          render_error("genere un nuevo token,token invalido o inexistente",:unprocessable_entity)
        end
 end

 def delete
        if user_for_token
          @quest=Question.find(params[:id])
              if  @quest.user_id==user_for_token.id
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
         render_error("genere un nuevo token,token invalido o inexistente",:unprocessable_entity)
        end
 end

 def respuestaCorrecta
 end

 private
 def question_params
   params.permit(:title,:description,:content)
 end

end