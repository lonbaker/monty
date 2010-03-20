require 'helper'

class TestMonty < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Monty::Watch.new(env)
  end

  def test_it_works
    get '/'
    assert last_response.ok?
  end

  def test_it_works_with_params
    get '/posts?tag=123'
    assert last_response.ok?
  end

end

