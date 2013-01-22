class ApplicationController < ActionController::Base
  protect_from_forgery

  def check_authorization
    if(session[:session_token].nil?)
      return_to=""
      if request.get? then
        return_to= "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
      end
      return_to = ("ref=" << return_to)
      redirect_to "#{Rails.application.routes.url_helpers.new_sessions_path}?#{return_to}"
    end
  end

end
