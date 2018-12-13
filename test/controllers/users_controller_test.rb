require 'test_helper'
require 'json'

class UsersControllerTest < ActionController::TestCase
  test "listar usuarios" do
  get :showUsers
  assert_response :success 
  assert_equal response.content_type, 'application/vnd.api+json'
  jdata = JSON.parse response.body
  assert_equal 3, jdata['data'].length
  end

  test "crear nuevo usuario de forma correcta"do
  @request.headers["Content-Type"] = 'application/vnd.api+json'
  post :create, params: {
                          username: 'User Number7',
                          screen_name: "hola",
                          password: 'password',
                          email: 'password@hotmail.com' }
      assert_response 201
  end
  test "crear nuevo usuario con username repetido"do
  @request.headers["Content-Type"] = 'application/vnd.api+json'
  post :create, params: {
                          username: 'agustin',
                          screen_name: "holas",
                          password: 'passwords',
                          email: 'passwords@hotmail.com' }
  assert_response 422
  end
  test "crear nuevo usuario con email repetido"do
  @request.headers["Content-Type"] = 'application/vnd.api+json'
  post :create, params: {
                          username: 'User Number7',
                          screen_name: "hola",
                          password: 'password',
                          email: 'agustin.c.96@hotmail.com' }
  assert_response 422
  end

  test "crear nuevo usuario con email invalido"do
  @request.headers["Content-Type"] = 'application/vnd.api+json'
  post :create, params: {
                          username: 'User Number7s',
                          screen_name: "holas",
                          password: 'passwords',
                          email: 'agustin.c.96hotmail.com' }
  assert_response 422
  end


end
