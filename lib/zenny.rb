require 'rubygems'
require 'uri'
require 'httpclient'
require 'multi_json'

module Zenny

  class << self

    def connect(server, user, pass, &block)
      Connection.new(server,user,pass,&block)
    end
  
    def router_path(router)
      router.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end
  end
end # Zenoss

require 'zenny/connection'
require 'zenny/exceptions'
