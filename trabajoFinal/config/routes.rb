Rails.application.routes.draw do

    get 'users', to: 'users#showUsers'
   
    post 'users', to: 'users#create'

    post 'sessions', to: 'users#session'

    get 'questions', to: 'questions#showall'

    get 'questions/:id', to: 'questions#show'

    post 'questions', to: 'questions#create'

    put 'questions/:id', to: 'questions#update'
     
    delete '/questions/:id', to: 'questions#delete'

    put '/questions/:id/resolve', to: 'questions#respuesta_correcta'

    get '/questions/:question_id/answers', to: 'answers#show'

    post '/questions/:question_id/answers', to: 'answers#create'

    delete '/questions/:question_id/answers/:id', to: 'answers#destroy'
end