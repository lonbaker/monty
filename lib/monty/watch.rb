# encoding: utf-8

module Monty
  class Watch
    def initialize(app, &block)
      @app = app

      instance_eval(&block) if block_given?
    end

    # Rack required method. For thread safety, dup self and execute _call
    def call(env)
      dup._call(env)
    end

    # Authorize request. Redirect if access is denied.
    def _call(env)

      unless allowed?(env) 
        return [302, redirect_headers, []]
      end

      @app.call(env)
    end

    private

    def allowed?(env)
      path = env['PATH_INFO']

      return true if path == '/'

      access_rights(env).match(path) 
    end

    # @return [Regexp] created from value of rack.session[:access_rights]
    def access_rights(env)
      ::Authorization.configure if Object.const_defined?('Authorization')
      
      session = env['rack.session'] || {}
      regex_string = session[:access_rights] || Monty::Configuration.public_access

      Regexp.new(regex_string)
    end

    def redirect_headers
      {'Location' => Monty::Configuration.access_denied_path, 'Content-Type' => 'text/html'}
    end
  end # Watch
end # Monty
