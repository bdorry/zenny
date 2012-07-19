module Zenny
  module JSONAPI
    def json_request(router, path, method, data={})
      path = "/zport/dmd/#{path}" unless path.start_with?('/zport/dmd')

      req_url = "#{@zenoss_uri}#{path}"

      req_headers = {'Content-type' => 'application/json; charset=utf-8'}
      req_body = MultiJson.encode [{
        :action => router,
        :method => method,
        :data   => data,
        :type   => 'rpc',
        :tid    => @request_number,
      }]

      @request_number += 1

      resp = @httpcli.post req_url, req_body, req_headers
      parse_json(resp)
    end

    private

    # Check the HTTP and JSON response for errors and return JSON response
    def parse_json(resp)
      #begin
        puts resp.http_body.content
      
        if(resp.status != 200)
          raise ZenossError, "Bad HTTP Response #{resp.status}: Cound not make JSON call"
        end
        
        json = MultiJson.decode(resp.http_body.content)
        
        # Check for JSON success. There are some exceptions where this doesn't make sense:
        #   1. Sometimes the 'success' key does not exist like in EventsRouter#query
        #   2. When json['result'] is not a Hash like a return from ReportRouter#get_tree
        if(json['result'].is_a?(Hash) && json['result'].has_key?('success') && !json['result']['success'])
          raise ZenossError, "JSON request '#{json['method']}' on '#{json['action']}' was unsuccessful"
        end

        json['result']
      #rescue JSON::ParserError => e
      #  raise ZenossError, "Invalid JSON response: #{e.message}"
      #end
    end

  end
end
