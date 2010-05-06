require 'helper'

class Authorization
  extend Monty::Access
end

class TestMonty < Test::Unit::TestCase

  def setup
    Monty::Configuration.reset
  end

  def app
    Monty::Watch.new(mock_framework)
  end

  def test_it_works
    get '/'
    assert last_response.ok?
  end

  def test_it_redirects
    get '/posts'
    assert last_response.redirect?
  end

  def test_it_allows_uri_without_ending_slash
    Authorization.permission :posts
    Authorization.public_access :posts

    get '/posts', {}
    assert last_response.ok?
  end

  def test_it_allows_uri_with_ending_slash
    Authorization.permission :posts
    Authorization.public_access :posts

    get '/posts/', {}
    assert last_response.ok?
  end

  def test_it_allows_uri_with_action
    Authorization.permission :posts
    Authorization.public_access :posts

    get '/posts/new', {}
    assert last_response.ok?

    get '/posts', {}
    assert last_response.ok?

    get '/posts/', {}
    assert last_response.ok?
  end

  def test_it_allows_uri_access_to_only_show
    Authorization.permission :posts do
      controller :posts do
        only :show
      end
    end
    Authorization.public_access :posts

    get '/posts/show', {}
    assert last_response.ok?

    get '/postsshow', {}
    assert last_response.redirect?

    get '/posts', {}
    assert last_response.redirect?

    get '/posts/', {}
    assert last_response.redirect?

    get '/posts/edit', {}
    assert last_response.redirect?
  end

  def test_it_allows_uri_access_to_all_except_show
    Authorization.permission :posts do
      controller :posts do
        except :show
      end
    end
    Authorization.public_access :posts

    get '/posts/show', {}
    assert last_response.redirect?

    get '/postsshow', {}
    assert last_response.redirect?

    get '/posts', {}
    assert last_response.ok?

    get '/posts/', {}
    assert last_response.ok?

    get '/posts/edit', {}
    assert last_response.ok?
  end
end

