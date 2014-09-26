RailsCasServer::Engine.routes.draw do
  get 'login' => 'cas#login'
  post 'login' => 'cas#sign_in'
end
