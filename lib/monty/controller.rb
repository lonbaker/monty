# encoding: utf-8

module Monty
  class Controller
    # Name of the controller
    attr_accessor :name
    # Regular expression pattern
    attr_accessor :regex_pattern
    # The only methods restricted on the controller
    attr_accessor :exceptions
    # The only methods allowed on the controller
    attr_accessor :inclusions


    # @param [String,Symbol] name controller reference. 
    def initialize(name)
      @name = name.to_s
      @regex_pattern = "\/#{@name}\/.*"
    end

    # @param *[String,Symbol] only methods restricted on the controller
    def except(*methods)
      return if methods.empty?
      @exceptions = methods.collect{|m| m.to_s}
      # \/my_controller\/(?!(show|update)).*
      @regex_pattern = "\/#{@name}\/(?!(#{@exceptions.join('|')})).*"
    end

    # @param *[String,Symbol] only methods allowed on the controller
    def only(*methods)
      return if methods.empty?
      @inclusions = methods.collect{|m| m.to_s}
      @regex_pattern = "\/#{@name}\/(#{@inclusions.join('|')})"
    end
  end # Controller
end # Monty
