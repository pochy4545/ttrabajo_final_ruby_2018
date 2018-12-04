Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    #Este es un endpoint para mi
    #xxxxx
    get 'users', to: 'users#showUsers'
    #Crea un nuevo usuario con los datos provistos en la petición.
    # Los atributos que se reciben son los correspondientes al modelo User. token:no
    #xxxx
    post 'users', to: 'users#create'

    #Inicia sesión con un usuario, cuyos nombre de usuario y clave se reciben en el
    #cuerpo de la petición en los parámetros username y password. De ser correctos el
    #nombre de usuario y contraseña, se debe generar un token temporal para el usuario 
    #y retornarlo, junto con los datos del usuario autenticado, en un atributo token para
    # que el frontend lo guarde y lo utilice en las peticiones a servicios que requieran
    # dicho token. La validez del token es de 30 minutos, pasados los cuales se deberá 
    #volver a identificar el usuario (mediante este mismo servicio) para así generarle 
    #un nuevo token. token:no
    #xxxxx
    post 'sessions', to: 'users#session'

    #Retorna un listado de las últimas 50 preguntas ordenadas el criterio especificado
    #mediante el parámetro :sort, que puede ser latest (ordena por fecha de creación, de
    #más a menos reciente, valor por defecto en caso de no incluirse el parámetro :sort),
    #pending_first (ordena priorizando las que no estén resueltas por sobre las que sí lo
    #están, y luego por fecha de creación de más a menos recientes), needing_help 
    #(sólo se incluyen las preguntas que no estén resueltas, y las ordena por cantidad de
    #respuestas de forma ascendente). Para cada pregunta se debe retornar el título, la
    #descripción acortada a 120 caracteres (de exceder esa cantidad de caracteres, rellenar
    #con elipsis: ...), la cantidad de respuestas que tiene y si está resuelta o no.
    #token:no
    #xxxxx
    get 'questions', to: 'questions#showall'

    #Retorna toda la información que se tiene de la pregunta identificada por el id recibido
    #en el parámetro :id. Opcionalmente puede solicitarse que en la respuesta a esta petición
    #se incluyan las respuestas (modelo Answer) a la pregunta, utilizando un Compound document.
    #token:no
    #xxxxx
    get 'questions/:id', to: 'questions#show'

    #Crea una nueva pregunta con los atributos que se reciban en la petición 
    #(título y descripción). Al crearla, se registra que el usuario que realiza la petición 
    #(identificado por su token) es el que publicó la pregunta.
    #token:si
    #xxxx
    post 'questions', to: 'questions#create'

    #Actualiza la pregunta existente identificada por el id recibido en el parámetro :id.
    #Este endpoint permite cambiar el título o la descripción de la pregunta. Sólo debe 
    #permitirse realizar las modificaciones si el usuario que se identifica mediante el 
    #token de la petición es el que publicó la pregunta.
    #token:si
    #xxxxx
    put 'questions/:id', to: 'questions#update'
     
    #Borra la pregunta existente identificada por el parámetro :id. No se debe permitir
    #el borrado si la pregunta tiene al menos una respuesta, o si la petición no es realizada
    #por el usuario que publicó la pregunta.
    #token:si
    #xxxxx 
    delete '/questions/:id', to: 'questions#delete'

    #Marca la pregunta identificada por :id como resuelta, marcando la respuesta identificada
    #por el parámetro :answer_id como respuesta correcta. Se debe validar que la respuesta esté
    #asociada a la pregunta, y que el usuario que realiza la petición sea el que publicó 
    #la pregunta.
    #token:si
    put '/questions/:id/resolve', to: 'questions#respuestaCorrecta'

    #Retorna todas las respuestas para la pregunta identificada por el id 
    #recibido en el parámetro :question_id.
    #token:no
    #xxxx
    get '/questions/:question_id/answers', to: 'questions#dameRespuestas'

    #Crea una nueva respuesta asociada a la pregunta identificada por el parámetro 
    #:question_id con el parámetro content recibido en la petición. Al crearla, se registra
    #que el usuario que realiza la petición (identificado por su token) es el que publicó la
    #respuesta. Si la pregunta está resuelta, no se debe admitir la creación de más respuestas,
    #retornando un código HTTP 422 Unprocessable entity.
    #token:si
    #xxxx
    post '/questions/:question_id/answers', to: 'questions#crearRespuesta'

    #Borra la respuesta existente, identificada por el parámetro :id y asociada a la pregunta 
    #identificada por el parámetro :question_id. No se debe permitir el borrado si la respuesta 
    #está marcada como respuesta correcta de la pregunta, o si la petición no es realizada por 
    #el usuario que publicó la respuesta.
    #token:si
    delete '/questions/:question_id/answers/:id', to: 'questions#eliminarRespuesta'
end