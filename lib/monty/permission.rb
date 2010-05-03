# encoding: utf-8

module Monty
  class Permission
    # Name of permission
    attr_accessor :name
    # Array of controller objects that define the access rights for this permission
    attr_accessor :controllers

    # @param [String,Symbol] name permission reference. 
    def initialize(name)
      @name = name.to_s
      @controllers = []
    end

    # @param [String,Symbol] name controller reference. 
    # @return new controller 
    def controller(name, &block)
      controller =  Monty::Controller.new(name)
      controller.instance_eval(&block) if block_given?
      @controllers << controller
      controller
    end

    # @return String representing all controllers defining this permission
    def regex_pattern
      controllers.collect{|c| "(#{c.regex_pattern})"}.join("|")
    end
  end # Permission
end # Monty
