class SessionsController < ApplicationController

  def new
    @ref_url = params[:ref]
  end

  def create
    RestClient.log = Logger.new(STDOUT)

    login = params[:userID]
    passwd = params[:passwd]

    @user = User.find_by_name(login)
    if(!@user.nil? && @user.password.eql?(passwd))
      session[:current_user] = @user
      ref = params[:ref_url]
      flash[:notice] = "Successfully authenticated!"
      if(ref.nil? || (ref.eql?(new_sessions_path))) then
        ref = root_url
      end
      redirect_to ref and return
    else
      flash[:alert] = "Authentication went wrong, please try it again!"
      redirect_to new_sessions_path and return
    end
  end

  def destroy
    session[:session_token] = nil
    reset_session
    flash[:notice] = "You've been successfully logged out"
    redirect_to root_url
  end
end
