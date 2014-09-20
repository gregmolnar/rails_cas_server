class RailsCasServer::CasController < ApplicationController
  def login
    @lt = RailsCasServer::LoginTicket.create!(host: request.ip)
  end
end
