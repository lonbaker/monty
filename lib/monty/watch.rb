# encoding: utf-8
module Monty
  class Watch
    attr_accessor :redirect_to

    def initialize(app, &block)
      @app = app

      instance_eval(&block) if block_given?

      @redirect_to ||= '/'
    end

    ##
    # Rack standard method. For thread safety, dup self and execute _call
    #
    def call(env)
      dup._call(env)
    end

    ##
    # Where the work is done
    def _call(env)
      status, headers, body = @app.call(env)

      @request = Rack::Request.new(env)

      if allowed_paths(env).match(@request.path)
        [status, headers, body]
      else
        [302, {'Location' => redirect_to}, []]
      end
    end

    private

    def allowed_paths(env)
      session = env['rack.session'] || {}
      regex_string = session[:access_rights] || '/^$/'
      Regexp.new(regex_string)
    end
  end
end
