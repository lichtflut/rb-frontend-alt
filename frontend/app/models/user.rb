class User < ActiveRecord::Base
  attr_accessible :name, :password, :active_host
  has_many :hosts, :dependent => :destroy
  belongs_to :active_host,  :class_name => "Host" , :foreign_key => "active_host_key"
end
