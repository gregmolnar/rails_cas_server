RailsCasServer::Engine.routes.draw do
  get 'login' => 'rails_cas_server/cas#login', as: :login
  post 'login' => 'rails_cas_server/cas#sign_in'
  get 'validate' => 'rails_cas_server/cas#validate', as: :validate
  get 'proxyValidate' => 'rails_cas_server/cas#proxy_validate', as: :proxy_validate
  get 'logout' => 'rails_cas_server/cas#logout'
end
