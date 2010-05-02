# encoding: utf-8

module Monty
  module Configuration
    class << self
      # Path to redirect to if access is denied. 
      # Default: '/'        
      attr_accessor :access_denied_path
      # Array of paths that are publicly accessible. 
      # Default ['/']
      attr_accessor :public_access
      # Array of paths that are restricted to an authenticated user.
      # Default []
      attr_accessor :protected_access
      # Array of permission objects that defines the access to the application.
      # Default []
      attr_accessor :permissions

      def reset
        @access_denied_path = '/'
        @public_access      = ['/']
        @protected_access   = []
        @permissions        = []
      end
    end

    self.reset
  end
end
