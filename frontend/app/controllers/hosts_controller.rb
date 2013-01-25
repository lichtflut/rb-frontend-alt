class HostsController < ApplicationController

  before_filter :check_authorization

  # GET user/user_id/hosts
  def index
    user_id = params[:user_id]
    @hosts = Host.find_all_by_user_id user_id
  end

# GET user/user_id/hosts/1

  def show
    @host = Host.find_by_user_id_and_id(session[:current_user], params[:id])
    render :action => :edit
  end

# GET /hosts/new
# GET /hosts/new.json
  def new
    @host = Host.new
  end

# GET user/user_id/hosts/1/edit
  def edit
    @host = Host.find_by_user_id_and_id(session[:current_user], params[:id])
  end

# POST user/user_id/hosts
  def create
    @host = Host.new(params[:host])
    @host.user_id=params[:user_id]

    respond_to do |format|
      if @host.save
        flash[:notice] = "Host was successfully created."
        redirect_to user_hosts_path(session[:current_user]) and return
      else
        format.html { render action: "new" }
      end
    end
  end

# PUT user/user_id/hosts/1
  def update
    @host = Host.find_by_user_id_and_id(params[:user_id], params[:id])

    respond_to do |format|
      if @host.update_attributes(params[:host])
        format.html { redirect_to [session[:current_user],@host], notice: 'Host was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def new_auth_token
    @host = Host.find_by_user_id_and_id(params[:user_id], params[:id])
  end

  def create_auth_token
    @host = Host.find_by_user_id_and_id(params[:user_id], params[:id])

    RestClient.log = Logger.new(STDOUT)

    login = params[:userID]
    passwd = params[:passwd]

    response = RestClient.post @host.service_uri + "/auth", {'password' => passwd, 'id' => login}.to_json, :content_type => :json do |response, request, result|
      response
    end

    if(response.code.eql?(201))
      token = response.cookies["lfrb-session-auth"]
      token = CGI::unescape(token)
      unless token.nil?
        @host.auth_token= token
        @host.save!
        redirect_to user_hosts_path(session[:current_user], @host) and return
      end
    end
    flash[:alert] = "Authentication went wrong, please try it again!"
    render :action => :new_auth_token
  end



# DELETE user/user_id/hosts/1
  def destroy
    @host = Host.find_by_user_id_and_id(params[:user_id], params[:id])
    @host.destroy
    respond_to do |format|
      format.html { redirect_to user_hosts_url }
    end
  end
end
