module Zenny
  module Routers
    module DeviceRouter

      def add_node(uid, context_uid, opts={})
        json_request('DeviceRouter', 'device_router', 'addNode', [{
          :id => uid,
          :description => opts[:description] || '',
          :type => opts[:type] || 'organizer',
          :contextUid => context_uid
        }])
      end

      def get_devices(uid, opts = {})
        data = {:uid => uid}
        data[:start] = opts[:start] if opts.has_key? :start
        data[:limit] = opts[:limit] if opts.has_key? :limit
        data[:sort] = opts[:sort_key] if opts.has_key? :sort_key
        data[:dir] = opts[:sort_ord] if opts.has_key? :sort_ord
        data[:params] = opts[:params] || {}

        json_request('DeviceRouter', 'device_router', 'getDevices', [data])
      end

      def get_component_tree(device_id)
        json_request('DeviceRouter', 'device_router', 'getComponentTree', [{:uid => device_id}])
      end

      def get_components(device_id, opts = {})
        data = {:uid => device_id}
        data[:meta_type] = opts[:meta_type] if opts.has_key? :meta_type
        data[:keys] = opts[:keys] if opts.has_key? :keys
        data[:start] = opts[:start] if opts.has_key? :start
        data[:limit] = opts[:limit] if opts.has_key? :limit
        data[:sort] = opts[:sort_key] if opts.has_key? :sort_key
        data[:dir] = opts[:sort_ord] if opts.has_key? :sort_ord
        data[:name] = opts[:name] if opts.has_key? :name

        json_request('DeviceRouter', 'device_router', 'getComponents', [data])
      end

      def get_info(device_id, keys = nil)
        data = {}
        data[:uid] = device_id
        data[:keys] = keys if keys
        json_request('DeviceRouter', 'device_router', 'getInfo', [data])
      end

      def find_devices_by_name(name, opts={})
        opts[:name] = name
        get_devices('/zport/dmd/Devices', :params => opts)
      end

      def find_devices_by_ip(ip, opts={})
        opts[:ipAddress] = ip
        get_devices('/zport/dmd/Devices', :params => opts)
      end

      def remodel(device_id)
        opts = {'deviceUid' => device_id}
        json_request('DeviceRouter', 'device_router', 'remodel', [opts])
      end

    end
  end
end

