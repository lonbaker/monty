require 'helper'

class TestMontyConfiguration < Test::Unit::TestCase

  def test_defaults_are_correct
    assert_equal Monty::Configuration.access_denied_path, '/'
    assert_equal Monty::Configuration.public_access, "\/"
    assert_equal Monty::Configuration.protected_access, "/^$/"
    assert_equal Monty::Configuration.permissions, []
  end
end

