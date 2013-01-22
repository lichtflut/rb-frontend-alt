require 'rest_client'


class EntitiesController < ApplicationController

  before_filter :check_authorization

  def index
    response = RestClient.get 'http://localhost:8080/brouker/service/entities'
    json  = ActiveSupport::JSON.decode(response.to_str)
    @entities = Array.new
    json["entities"].each do |e|
      @entities << map_json_rsp_to_entity(e)
    end

    # respond_to do |format|
    #format.html  {render :text => @entities.inspect}
    #format.json { render :json => entities }
    #format.xml { render :xml => entities.to_xml }
    #format.all { render :text => @whole_response }
    # end

  end

  #-------------------------------

  def show
    id = params[:id]
    response = RestClient.get ('http://localhost:8080/brouker/service/entities/' << id)
    json = ActiveSupport::JSON.decode(response.to_str)
    @entity = map_json_rsp_to_entity(json)
  end

  #-------------------------------

  def new

  end

  #---------------------------------

  def delete

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
