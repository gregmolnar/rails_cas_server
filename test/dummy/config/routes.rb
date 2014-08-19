Rails.application.routes.draw do

  mount RailsCasServer::Engine => "/rails_cas_server"
end
