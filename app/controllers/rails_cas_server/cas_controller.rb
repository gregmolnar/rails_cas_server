class RailsCasServer::CasController < ApplicationController
  def login
    ticket = RailsCasServer::ServiceTicket.find_by(host: request.ip, session_id: session.id)
    if params[:redirection_loop_intercepted].nil? && !ticket.nil? && !params[:service].nil?
      redirect_to "#{params[:service]}?ticket=#{ticket.to_s}"
    end
    @lt = RailsCasServer::LoginTicket.create!(host: request.ip)
  end

  def sign_in
    return redirect_to("/login", status: 500, alert: "Invalid login ticket") if RailsCasServer::LoginTicket.valid(params[:lt]).first.nil?
    if RailsCasServer.configuration.authenticator.new.verify(params[:username], params[:password])
      ticket = RailsCasServer::ServiceTicket.create!(username: params[:username], host: request.ip, session_id: session.id)
      cookies.signed[:tgt] = ticket.cookie
      if !params[:service].nil? and RailsCasServer.configuration.allowed_services.keys.include?(URI(params[:service]).host)
        redirect_to "#{params[:service]}?ticket=#{ticket.to_s}"
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

  def proxy_validate
    @ticket = RailsCasServer::ServiceTicket.not_consumed.where(ticket: params[:ticket]).where("service IS NULL or service = ?", params[:service]).first
    if @ticket.nil?
      render :service_validate_error, formats: [:xml]
    else
      @ticket.consume!
      render :service_validate_success, formats: [:xml]
    end
  end

end
