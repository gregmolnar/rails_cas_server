require 'test_helper'

class RailsCasServer::CasControllerTest < ActionController::TestCase

  test "should get login" do
    get :login, use_route: :rails_cas_server
    assert_response :success
  end

  test "it accepts valid login ticket" do
    ticket = RailsCasServer::LoginTicket.create!(host: '0.0.0.0')
    post :login, lt: ticket, use_route: :rails_cas_server
    assert_response :success
  end

  test "it refuses invalid login ticket" do
    post :login, lt: "Foobar", use_route: :rails_cas_server
    assert_response :success
  end
end
