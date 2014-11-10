class RailsCasServer::CasController < ApplicationController
  def login
    @lt = RailsCasServer::LoginTicket.create!(host: request.ip)
  end

  def sign_in
    return redirect_to("/login", status: 500, alert: "Invalid login ticket") if RailsCasServer::LoginTicket.valid(params[:lt]).first.nil?
    if RailsCasServer.configuration.authenticator.new.verify(params[:username], params[:password])
      ticket = RailsCasServer::ServiceTicket.create!(username: params[:username], host: request.ip, session_id: session.id, service: params[:service])
      # TODO: implement whitelist of services
      if !params[:service].nil?
        redirect_to "#{params[:service]}?ticket=#{ticket}"
      else
        flash[:notice] = "Successfull login"
        render(action: :login)
      end
    else
      redirect_to "/login", status: 401, alert: "Invalid login"
    end
  end

  def validate
    ticket = RailsCasServer::ServiceTicket.where(session_id: session.id, ticket: params[:ticket]).where("service IS NULL or service = ?", params[:service]).first
    if ticket.nil?
      render text: "no\n\n"
    else
      ticket.touch
      render text: "yes\n"
    end
  end
end
