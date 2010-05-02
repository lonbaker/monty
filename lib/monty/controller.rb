# encoding: utf-8

module Monty
  class Controller
    # Name of the controller
    attr_accessor :name

    # Regular expression pattern
    attr_accessor :regex_pattern

    # @param [String,Symbol] name controller reference. 
    def initialize(name)
      @name = name.to_s
      @regex_pattern = "\/#{@name}\/.*"
    end

    # @param [String,Symbol] name controller reference. 
    def except(*methods)
      return if methods.empty?
      @exceptions = methods
      # \/my_controller\/(?!(show|update)).*
      @regex_pattern = "\/#{@name}\/(?!(#{@exceptions.join('|')})).*"
    end

    def only(*methods)
      return if methods.empty?
      @inclusions = methods
      @regex_pattern = "\/#{@name}\/(#{@inclusions.join('|')})"
    end
  end
end
