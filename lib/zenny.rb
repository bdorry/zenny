require 'rubygems'
require 'uri'
require 'httpclient'
require 'multi_json'

module Zenny

  class << self

    def connect(server, user, pass, &block)
      Connection.new(server,user,pass,&block)
    end
  
  end
end # Zenoss

require 'zenny/connection'
require 'zenny/exceptions'
