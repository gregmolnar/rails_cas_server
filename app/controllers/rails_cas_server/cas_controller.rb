class RailsCasServer::CasController < ApplicationController
  def login
    @lt = RailsCasServer::LoginTicket.create!(host: request.ip)
  end

  def sign_in
    return redirect_to("/login", status: 500, alert: "Invalid login ticket") if RailsCasServer::LoginTicket.valid(params[:lt]).first.nil?
    if RailsCasServer.configuration.authenticator.new.verify(params[:username], params[:password])
      RailsCasServer::ServiceTicket.create!(username: params[:username], host: request.ip, session_id: session.id, service: params[:service])
      # TODO: implement whitelist of services
      if !params[:service].nil?
        redirect_to params[:service]
      else
        flash[:notice] = "Successfull login"
        render(action: :login)
      end
    else
      redirect_to "/login", status: 401, alert: "Invalid login"
    end
  end
end
