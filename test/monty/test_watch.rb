require 'helper'

class TestMonty < Test::Unit::TestCase

  def app
    Monty::Watch.new(mock_framework)
  end

  def test_it_works
    get '/',{}, {'rack.session' => {:access_rights => '\/'}}
    assert last_response.ok?
  end

  def test_it_redirects
    get '/posts',{}
    assert last_response.redirect?
  end

end

