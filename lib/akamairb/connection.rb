require "json"
require "faraday"

module Akamai
  class Connection
    attr_accessor :conn

    def initialize(config)
      self.conn = Faraday.new(:url => 'https://api.ccu.akamai.com') do |faraday|
        faraday.headers['Content-Type'] = 'application/json'
        faraday.adapter Faraday.default_adapter  # make requests with Net::HTTP
        faraday.basic_auth(config["user"],config["pass"])
      end
    end

    def purge(*urls)
      response = conn.post do |req|
        req.url '/ccu/v2/queues/default'
        req.body = JSON.dump({"objects" => urls.flatten})
      end
      
      parse response
    end

    def progress url
      parse conn.get(url)
    end

    def progress_until_done url
      loop do
        response = progress url
        yield response if block_given?
        break if response["purgeStatus"] == "Done"
        sleep response["pingAfterSeconds"]
      end
    end

    def purge_and_progress *urls, &block
      response = purge *urls
      progress_until_done response["progressUri"], &block
    end

    private
    def parse response
      JSON.parse(response.body)
    end
  end
end
