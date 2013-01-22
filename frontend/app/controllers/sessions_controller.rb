class SessionsController < ApplicationController

  def new
    @ref_url = params[:ref]
  end

  def create
    login = params[:userid]
    passwd = params[:passwd]
    session[:session_token] = "token_dummy"
    ref = params[:ref_url]
    if(ref.nil? || (ref.eql?(new_sessions_path))) then
      ref = root_url
    end

    redirect_to ref
  end

  def destroy
    session[:session_token] = nil
    redirect_to root_url
  end
end
