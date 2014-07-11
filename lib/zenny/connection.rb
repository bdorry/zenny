require 'zenny/jsonapi'
require 'zenny/routers/device_router'
require 'zenny/routers/events_router'
require 'zenny/routers/sshkey_uploader_router'

module Zenny

  # This class represents a connection into a Zenoss server.
  class Connection
    include Zenny::JSONAPI
    include Zenny::Routers::DeviceRouter
    include Zenny::Routers::EventsRouter
    include Zenny::Routers::SSHKeyUploaderRouter
    
    def initialize(url, user, pass, &block)
      @zenoss_uri = (url.is_a?(URI) ? url : URI.parse(url))
      @request_number = 1
      @httpcli = HTTPClient.new
      @httpcli.receive_timeout = 360  # six minutes should be more that sufficient
      yield(@httpcli) if block_given?
      sign_in(user,pass)
    end

    private

    # Sign-in to this Zenoss instance.
    def sign_in(user,pass)
      login_parms = {
        :__ac_name     => user,
        :__ac_password => pass,
        :submitted     => true,
        :came_from     => "#{@zenoss_uri}/zport/dmd",
      }
      login_path = "#{@zenoss_uri}/zport/acl_users/cookieAuthHelper/login"
      resp = @httpcli.post login_path, login_parms
      if(resp.status == 302)
        login_path = "#{@zenoss_uri}#{resp.header['Location'].first}"
        resp = @httpcli.post login_path, login_parms
        raise Zenny::ZenossError, "(HTTP Response #{resp.status}) Could not authenticate to #{@zenoss_uri}" unless resp.status == 200
      end
      true
    end

  end
end
