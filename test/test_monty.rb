require 'helper'

class TestMonty < Test::Unit::TestCase

  def test_version
    assert Monty.version, '0.1.0'
  end

  def test_authenticated_access
    Monty::Configuration.public_access = "(/static/.*)"
    Monty::Configuration.protected_access = "(/users/.*)"
    assert_equal Monty.authenticated_access, "(/static/.*)|(/users/.*)"
  end

end

