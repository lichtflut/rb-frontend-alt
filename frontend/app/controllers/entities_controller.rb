require 'rest_client'


class EntitiesController < ApplicationController

  before_filter :check_authorization

  def index
    flash[:notice]=nil
    @active_host = session[:current_user].active_host
    if @active_host.nil?
      flash[:alert] = "You have first to enable a service host on which you want rely"
      return
    end
    unless @active_host.is_alive?
      flash[:alert] = "Your selected host is not alive"  and return
    end
    #let's get the domains
    response = RestClient.get(@active_host.service_uri + "/domains/" ,:cookies => {"lfrb-session-auth" => CGI::escape(@active_host.auth_token)})
    json  = ActiveSupport::JSON.decode(response.to_str)
    @domains = Array.new
    json["domains"].each do |d|
      @domains << map_json_rsp_to_domain(d)
    end
    @entities = Array.new
    unless params[:domain].nil?
      @domain = params[:domain]
      response = RestClient.get(@active_host.service_uri + "/domain/" +  @domain +  "/entities" ,
                                :cookies => {"lfrb-session-auth" => CGI::escape(@active_host.auth_token)})
      json  = ActiveSupport::JSON.decode(response.to_str)
      json["entities"].each do |e|
        @entities << map_json_rsp_to_entity(e)
      end

      if @entities.empty?
        flash[:notice] = "No entities were found"
      end
    end

  end

  #-------------------------------

  def show
    @active_host = session[:current_user].active_host
    if @active_host.nil?
      flash[:alert] = "You have first to enable a service host on which you want rely"
      redirect_to root_path and return
    end
    unless @active_host.is_alive?
      flash[:alert] = "Your selected host is not alive"  and return
    end
    id = params[:id]
    @domain = params[:domain]
    if @domain.nil?
      flash[:alert] = "Missing domain"
      redirect_to root_path and return
    end
    response = RestClient.get(@active_host.service_uri + "/domain/" +  @domain +  "/entities/" + id,
                              :cookies => {"lfrb-session-auth" => CGI::escape(@active_host.auth_token)})
    json = ActiveSupport::JSON.decode(response.to_str)
    @entity = map_json_rsp_to_entity(json)
  end

  #-------------------------------

  def new

  end

  #---------------------------------

  def delete

  end

  def map_json_rsp_to_domain(json_object)
    domain = Domain.new
    domain.title= json_object["title"]
    domain.description= json_object["description"]
    domain.name= json_object["name"]
    domain
  end

  def map_json_rsp_to_entity(json_object)
    entity = Entity.new
    entity.originalID= json_object["id"]
    json_object["associations"].each do |a|
      assoc = Assoc.new
      assoc.predicate= a["predicate"]
      assoc.object= a["object"]
      if  a["entityAssoc"] == true
        assoc.is_entity_assoc = true
        assoc.object = Entity.new
        assoc.object.originalID = a["object"]
      end
      entity.associations= assoc
    end
    entity
  end

end
