require 'rubygems'
require 'test/unit'
require 'rack/test'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'monty'

class Test::Unit::TestCase
end

def env
  lambda { |env| [200, {'Content-Type' => 'text/plain'}, 'OK'] }
end
