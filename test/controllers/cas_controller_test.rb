require 'test_helper'

class RailsCasServer::CasControllerTest < ActionController::TestCase
  test "should get login" do
    get :login, use_route: :rails_cas_server
    assert_response :success
  end
end
