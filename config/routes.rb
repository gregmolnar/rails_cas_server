RailsCasServer::Engine.routes.draw do
  get 'login' => 'rails_cas_server/cas#login', as: :login
  post 'login' => 'rails_cas_server/cas#sign_in'
end
