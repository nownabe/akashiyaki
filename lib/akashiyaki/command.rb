# frozen_string_literal: true

require "akashiyaki/client"

module Akashiyaki
  class Command
    attr_reader :mode, :action, :account

    def initialize(mode, action, account)
      @mode = mode
      @action = action
      @account = account
    end

    def run
      client.send(:"#{action}_#{mode}")
    end

    private

    def client
      @client ||=
        Client.new(
          account.company,
          account.id,
          account.password
        )
    end
  end
end
