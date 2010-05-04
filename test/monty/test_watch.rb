require 'helper'

class TestMonty < Test::Unit::TestCase

  def app
    Monty::Watch.new(mock_framework)
  end

  def test_it_works
    get '/', {}, {}
    assert last_response.ok?
  end

  def test_it_redirects
    get '/posts', {}, {'rack.session' => {:access_rights => "/blog/.*"}}
    assert last_response.redirect?
  end

end

