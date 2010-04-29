# encoding: utf-8
module Monty
  class Watch
    # Path to redirect to if access is denied
    #   Defaults to '/'
    attr_accessor :access_denied_path

    def initialize(app, &block)
      @app = app

      instance_eval(&block) if block_given?

      @access_denied_path ||= '/'
    end

    # Rack required method. For thread safety, dup self and execute _call
    def call(env)
      dup._call(env)
    end

    # Authorize request. Redirect if access is denied.
    def _call(env)
      status, headers, body = @app.call(env)

      @request = Rack::Request.new(env)

      if allowed_paths(env).match(@request.path)
        [status, headers, body]
      else
        [302, {'Location' => access_denied_path}, []]
      end
    end

    private

    # @return [Regexp] derived from value of rack.session[:access_rights]
    def allowed_paths(env)
      session = env['rack.session'] || {}
      regex_string = session[:access_rights] || '/^$/'
      Regexp.new(regex_string)
    end
  end
end
