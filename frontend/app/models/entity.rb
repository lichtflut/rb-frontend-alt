class Entity < ActiveResource::Base

  #Specify the data container
  self.element_name= "Node"

  #Define the schema
  schema do
    attribute 'uri', 'string'
  end

end
