require 'helper'

class TestMontyPermission < Test::Unit::TestCase

  def setup
    @permission = Monty::Permission.new(:my_account)
  end

  def test_initializer_sets_correct_state
    assert_equal @permission.name, 'my_account'
  end
end

