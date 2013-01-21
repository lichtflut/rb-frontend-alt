require 'rest_client'


class EntitiesController < ApplicationController

  def initialize

  end


  def index
    response = RestClient.get 'http://localhost:8080/brouker/service/entities'
    @json_response = response.to_str
    @json  = ActiveSupport::JSON.decode(@json_response)
    @entities = Array.new
    @json["entities"].each do |e|
      entity = Entity.new
      entity.originalID= e["id"]
      e["associations"].each do |a|
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

      @entities << entity
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

    @entity = Entity.new
    @entity.originalID= json["id"]
    json["associations"].each do |a|
      assoc = Assoc.new
      assoc.predicate= a["predicate"]
      assoc.object= a["object"]
      if  a["entityAssoc"] == true
        assoc.is_entity_assoc = true
        assoc.object = Entity.new
        assoc.object.originalID = a["object"]
      end
      @entity.associations= assoc
    end
  end

  #-------------------------------

  def new

  end

  #---------------------------------

  def delete

  end

end
