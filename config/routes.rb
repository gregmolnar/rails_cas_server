RailsCasServer::Engine.routes.draw do
  get 'login' => 'rails_cas_server/cas#login'
  post 'login' => 'rails_cas_servercas#sign_in'
end
