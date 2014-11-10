require 'test_helper'

class RailsCasServer::CasControllerTest < ActionController::TestCase
  setup do
    authenticator = RailsCasServer::Authenticators::SqlAuthenticator
    authenticator.configure do |config|
      config.database = { adapter: 'sqlite3', database: File.join(Rails.root, 'db', 'test.sqlite3') }
      config.table = "users"
      config.username_field = :username
      config.password_field = :password
    end
    RailsCasServer.configure do |config|
      config.authenticator = authenticator
    end
  end

  test "should get login" do
    get :login, use_route: :rails_cas_server
    assert_response :success
  end

  test "it refuses invalid login ticket" do
    post :sign_in, lt: "Foobar", use_route: :rails_cas_server
    assert_response :error
  end

  test "it accepts valid login ticket" do
    ticket = RailsCasServer::LoginTicket.create!(host: '0.0.0.0')
    post :sign_in, lt: ticket.ticket, username: 'johndoe', password: '123456', use_route: :rails_cas_server
    assert_response :success
  end

  test "it it redirects to service if provided" do
    ticket = RailsCasServer::LoginTicket.create!(host: '0.0.0.0')
    post :sign_in, lt: ticket.ticket, username: 'johndoe', password: '123456', service: 'https://myservice.mytld', use_route: :rails_cas_server
    assert_redirected_to 'https://myservice.mytld'
  end
end
