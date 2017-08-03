# coding: utf-8
# frozen_string_literal: true

require "thor"

require "akashiyaki/account_parser"
require "akashiyaki/command"

module Akashiyaki
  class Cli < Thor
    class << self
      def mode(mode, start, finish)
        desc "#{mode} ACTION [options]", "#{start}/#{finish}"
        subcommand mode, command_class(mode, start, finish)
      end

      private

      def command_class(mode, start, finish)
        Class.new(Thor).tap do |c|
          c.desc "start [options]", start
          c.send(:define_method, :start) do
            Command.new(
              mode,
              :start,
              AccountParser.new(options).parse
            ).run
          end

          c.desc "finish [options]", finish
          c.send(:define_method, :finish) do
            Command.new(
              mode,
              :finish,
              AccountParser.new(options).parse
            ).run
          end
        end
      end
    end

    class_option :config, type: :string
    class_option :company, aliases: "-c", type: :string
    class_option :id, aliases: "-i", type: :string
    class_option :password, aliases: "-p", type: :string

    mode("work", "出勤", "退勤")
    mode("break", "休憩開始", "休憩終了")
  end
end
