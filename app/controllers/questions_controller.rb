class QuestionsController < ApplicationController
 
 #verificado### 
 def showall
    @result = case question_params[:sort]
    when "pending_first"then Question.by_pending_first
    when "needing_help"then Question.needing_help
    else Question.natural_order end	 
    render json: @result.last(50) ,each_serializer: QuestionshowallSerializer
 end

 #verificado###
 def show
    @quest=Question.find(params[:id])
    if (!question_params[:answer].blank?) 
        render json: @quest, serializer:  QuestionandanswershowSerializer ,include: ['answers']
    else
        render json: @quest , serializer: QuestionshowSerializer
    end
 end
 #verificado###
 def create
    if(user_for_token)
      @question=Question.new(question_params)
      @question.user_id = user_for_token.id
      if @question.save
         render_error("preguta creada",:created)
      else
         render json: @question.errors, status: :unprocessable_entity
      end
    else
      render_error("genere un nuevo token,token invalido o inexistente",:unprocessable_entity)
    end
 end

#verificado###
 def update
    @quest=Question.find_by!(id: params[:id] ,user: user_for_token)
    if @quest.update_attributes(question_params)
      render json: @quest , status: :accepted
    else
      render json: @quest.errors, status: :unprocessable_entity
    end
 end
#vefificado###
 def delete
    if user_for_token
      @quest=Question.find(params[:id])
      if  @quest.user_id==user_for_token.id
        @quest.validar = false
        if @quest.destroy
          render json: {:mensaje => "pregunta eliminada"},status:200
       else
        render json: @quest.errors , status: :unprocessable_entity
       end  
      else
        render_error("no tiene previlegios para borrar la pregunta", :unauthorized)
      end
    else
      render_error("genere un nuevo token,token invalido o inexistente",:unprocessable_entity)
    end
 end

 #verificado###
 def respuesta_correcta
   @quest=Question.find_by!(id:params[:id], user:user_for_token)
   @quest.validar = true
   if @quest.update_attributes(status: true , answer_id: question_params[:answer_id])
       render json: {:mensaje => "pregunta respondida"},status:200
   else
       render json: @quest.errors , status: :unprocessable_entity
   end   
  end
 
 private
 def question_params
   params.permit(:title,:description,:answer,:sort,:answer_id)
 end

end