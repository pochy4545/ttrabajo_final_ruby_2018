class QuestionsController < ApplicationController

 def showall
    @questions=Question.all
    #if question_params[:sort].exist?
    #  @result= case question_params[:sort]
    #   when "latest" then @result = @questions.order(created_at: :desc)
    #   when "pending_first"then @result = @result=@questions.order()
    #   when "needing_help"then @result= @result=@questions.order()
    #   else
    #   	@result=""
    #   end	 
    #else 
    #	@result = @questions.order(created_at: :desc)
    #end
    render json: @questions
 end

 def show

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

 end

 def delete

 end

 def until
 end

 def question_params
    params.require(:question).permit(:title,:description,:status,:sort,:token)
 end

end