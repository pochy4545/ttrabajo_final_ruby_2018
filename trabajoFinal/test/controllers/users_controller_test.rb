require 'test_helper'
require 'json'

class UsersControllerTest < ActionController::TestCase
  test "crear nuevo usuario enviando el correcto content type pero sin cuepo"do |variable|
  	post :create,params:{data:{
  		type: 'users',
  		attributes:{
  			username: nil,
  			password: nil,
  			email: nil
  		}
  		}}
  	assert_response 400
  end
end