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
    def controller(name, &block)
      controller =  Monty::Controller.new(name)
      controller.instance_eval(&block) if block_given?
      @controllers << controller
      controller
    end
  end # Permission
end # Monty
