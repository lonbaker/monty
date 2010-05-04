# encoding: utf-8

$:.unshift(File.dirname(__FILE__))

module Monty
  def self.version
    '0.1.0'
  end

  def self.authenticated_access
    Monty::Configuration.public_access + "|" + Monty::Configuration.protected_access
  end
end

require 'monty/configuration'
require 'monty/watch'
require 'monty/controller'
require 'monty/permission'
require 'monty/access'
