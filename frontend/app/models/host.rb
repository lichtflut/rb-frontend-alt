require 'rest_client'

class Host < ActiveRecord::Base
  attr_accessible :auth_token, :service_uri, :alias
  belongs_to :user

  def is_alive?
    response = nil
    begin
      response = RestClient.get self.service_uri do |r, request, result|
        r
      end
    rescue Exception
    end

    if(response.nil? || !response.code.eql?(200))
      return false
    else
      if response.to_s.include?"http://rb.lichtflut.de/rels/self"
        return true
      else
        return false
      end
    end
  end
  validates :service_uri, :presence  => true

end
