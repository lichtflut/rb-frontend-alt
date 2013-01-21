require 'base64'

class Entity

  attr_accessor :id
  attr_accessor :originalID

  def originalID= id
    @originalID = id.tr("\n","")
    #There is a bug in the encoding which results in adding a line feed at the end
    @id= Base64.encode64(@originalID).tr("\n","")
  end


  def associations= assoc
    if ! @associations then
      @associations = Array.new
    end
    @associations << assoc
  end

  def associations
    if(! @associations) then
      @associations = Array.new
    end
    @associations
  end



  #Specify the data container
  #self.element_name= "entity"
  #self.format = :json
  #self.site = "http://localhost:8080/brouker/service/"

  #Define the schema
  #schema do
  #  attribute 'uri', 'string'
  #  attribute 'name' , 'string'
  #end

end
