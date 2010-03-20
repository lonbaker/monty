# encoding: utf-8
module Monty
  class Watch
    def initialize(app, &block)
      @app = app

      instance_eval(&block) if block_given?
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      status, headers, body = @app.call(env)

      request = Rack::Request.new(env)

      [status, headers, body]
    end
  end
end
