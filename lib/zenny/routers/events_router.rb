module Zenny
  module Routers
    module EventsRouter
        
      def get_events(uid, opts = {})
        data = opts.merge(:uid => uid)

        data[:limit] ||= 100

        json_request('EventsRouter','evconsole_router','query',[data])
      end

    end
  end
end
