require 'yaml'
require 'thor'
require 'pp'

module Akamai
  class Command < Thor

    include Thor::Actions

    desc "purge URLS", "purge urls from Akamai"
    option :debug, :type => :boolean
    def purge(*urls)
      client = Akamai::Connection.new(config)
      client.purge_and_progress(*urls, &printter) 
      puts
    end

    desc "show ID", "show progress of a purge"
    option :debug, :type => :boolean
    def show(id)
      client = Akamai::Connection.new(config)
      client.progress_until_done("/ccu/v2/purges/#{id}", &printter)
      puts
    end

    private

    def config
      begin
        config_path = "#{Dir.home}/.akamai.yml"
        config_file = open(config_path)
        config = YAML.load(config_file)
      rescue
        config = nil
      end

      unless config
        say "Configuration is empty. Please check your '~/.akamai.yml'", :red
        exit -1
      end

      config
    end

    def printter
      Proc.new do |response|
        if options[:debug]
          puts
          pp response
        else
          print "         \r#{response["purgeId"]} => #{response["purgeStatus"]}"
        end
      end
    end

  end
end
