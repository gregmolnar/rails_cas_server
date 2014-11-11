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

  test "it redirects to service if provided" do
    ticket = RailsCasServer::LoginTicket.create!(host: '0.0.0.0')
    post :sign_in, lt: ticket.ticket, username: 'johndoe', password: '123456', service: 'https://myservice.mytld', use_route: :rails_cas_server
    assert_redirected_to "https://myservice.mytld?ticket=#{RailsCasServer::ServiceTicket.last}"
  end

  test "it does not redirect to not allowed service" do
    ticket = RailsCasServer::LoginTicket.create!(host: '0.0.0.0')
    post :sign_in, lt: ticket.ticket, username: 'johndoe', password: '123456', service: 'https://badguy.mytld', use_route: :rails_cas_server
    assert_response :success
  end

  test "it rejects invalid service ticket" do
    get :validate, ticket: 'foobar', use_route: :rails_cas_server
    assert_response :success
    assert_equal "no\n\n", response.body
  end

  test "it approves valid service ticket" do
    ticket = RailsCasServer::ServiceTicket.create!(host: '0.0.0.0', session_id: session.id, username: 'test')
    get :validate, ticket: ticket.to_s, use_route: :rails_cas_server
    assert_response :success
    assert_equal "yes\n", response.body
  end

  test "it rejects wrong service ticket on proxyValidate" do
    ticket = RailsCasServer::ServiceTicket.create!(host: '0.0.0.0', session_id: session.id, username: 'test')
    get :proxy_validate, ticket: "nonono", use_route: :rails_cas_server
    assert_response :success
    assert_equal "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<cas:serviceResponse xmlns:cas=\"http://www.yale.edu/tp/cas\">
  <cas:authenticationFailure code=\"BAD_PGT\">Invalid ticket</cas:authenticationFailure>
</cas:serviceResponse>
", response.body
  end

  test "it validates service ticket on proxyValidate" do
    ticket = RailsCasServer::ServiceTicket.create!(host: '0.0.0.0', session_id: session.id, username: 'test')
    cookies.signed[:tgt] = ticket.cookie
    get :proxy_validate, ticket: ticket.to_s, use_route: :rails_cas_server
    assert_response :success
    assert_equal "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<cas:serviceResponse xmlns:cas=\"http://www.yale.edu/tp/cas\">
  <cas:authenticationSuccess>
    <cas:user>#{ticket.username}</cas:user>
  </cas:authenticationSuccess>
</cas:serviceResponse>
", response.body
  end
end
