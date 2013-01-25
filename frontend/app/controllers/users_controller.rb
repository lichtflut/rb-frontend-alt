class UsersController < ApplicationController

  before_filter :check_authorization , :except => [:new, :create]

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    render :action => :edit
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        session[:current_user] = @user
        format.html { redirect_to root_path, notice: "You\'ve been successfully registered" }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #PUT /users/1
  def enable_host
    @user = User.find(params[:id])
    @host = Host.find(params[:host])
    @user.active_host=@host
    @user.save
    session[:current_user] = @user
    flash[:notice] = "Active host has been set to " + @host.service_uri
    redirect_to user_hosts_path(@user)
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
      @user = User.find(params[:id])
    if(session[:current_user].eql?(@user))
      @user.destroy
      redirect_to logout_path and return
    end
  else
     redirect_to root_path
  end
end
