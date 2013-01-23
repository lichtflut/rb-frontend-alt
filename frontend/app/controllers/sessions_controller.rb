class SessionsController < ApplicationController

  def new
    @ref_url = params[:ref]
  end

  def create
    RestClient.log = Logger.new(STDOUT)

    login = params[:userID]
    passwd = params[:passwd]
    response = RestClient.post "http://localhost:8080/brouker/service/auth", {'password' => passwd, 'id' => login}.to_json, :content_type => :json do |response, request, result|
      response
    end

    if(response.code.eql?(201))
      token = response.cookies["lfrb-session-auth"]
      unless token.nil?
        session[:session_token] = token
        ref = params[:ref_url]
        flash[:notice] = "Successfully authenticated!"
        if(ref.nil? || (ref.eql?(new_sessions_path))) then
          ref = root_url
        end
        redirect_to ref and return
      end
    end
    flash[:alert] = "Authentication went wrong, please try it again!"
    redirect_to new_sessions_path and return
  end

  def destroy
    session[:session_token] = nil
    flash[:notice] = "You've been successfully logged out"
    redirect_to root_url
  end
end
