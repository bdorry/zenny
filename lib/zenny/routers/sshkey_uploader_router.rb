module Zenny
  module Routers
    module SSHKeyUploaderRouter
      def upload_ssh_key(device_uid, ssh_key)
        data = {:deviceUid => device_uid, :key => ssh_key}
        json_request('SSHKeyUploaderRouter', 'SSHKeyUploaderRouter', 'setKey', [data])
      end
    end
  end
end


