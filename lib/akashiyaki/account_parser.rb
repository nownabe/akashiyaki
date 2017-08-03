# frozen_string_literal: true

require "io/console"
require "json"
require "yaml"

require "akashiyaki/account"

module Akashiyaki
  class AccountParser
    def initialize(options)
      @options = options
    end

    def parse
      Account.new(company, id, password)
    end

    private

    def company
      return @options[:company] if @options[:company]
      return config["company"] if config["company"]

      print "Company ID: "
      STDIN.gets.chomp
    end

    def config
      @config ||= load_config_file
    end

    def id
      return @options[:id] if @options[:id]
      return config["id"] if config["id"]

      print "Login ID: "
      STDIN.gets.chomp
    end

    def password
      return @options[:password] if @options[:password]
      return config[:password] if config[:password]

      print "Password: "
      STDIN.noecho(&:gets).chomp
    end

    def search_config
      if @options[:config]
        path = File.expand_path(@options[:config])
        return path if File.exist?(path)
      end

      %w(json yaml yml).each do |ext|
        path = File.join(config_dir, "account.#{ext}")
        return path if File.exist?(path)
      end

      nil
    end

    def config_dir
      @config_dir ||=
        File.join(
          ENV["XDG_CONFIG_HOME"] || File.expand_path("~/.config"),
          "ak4"
        )
    end

    def load_config_file
      config_file = search_config

      return {} unless config_file

      case config_file
      when /\.json$/
        JSON.parse(File.read(config_file))
      when /\.ya?ml$/
        YAML.load_file(config_file)
      end
    end
  end
end
