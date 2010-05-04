require 'rubygems'
require 'test/unit'
require 'rack/test'
require 'mocha'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'monty'

class Test::Unit::TestCase
  include Rack::Test::Methods

end

def mock_framework
  framework = mock 'framework'
  framework.stubs :call => [200, {'Content-Type' => 'text/plain'}, 'OK'] 
  framework 
end

