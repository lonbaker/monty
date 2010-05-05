require 'helper'

class TestMontyPermission < Test::Unit::TestCase

  def setup
    @permission = Monty::Permission.new(:my_account)
  end

  def test_initializer_sets_correct_state
    assert_equal @permission.name, 'my_account'
    assert_equal @permission.controllers, []
  end

  def test_controller
    @permission.controller(:users)

    controller = @permission.controllers.first
    assert_equal controller.name, 'users'
  end

  def test_controller_with_block
    @permission.controller(:users) do
      except :destroy
    end

    controller = @permission.controllers.first
    assert_equal controller.exceptions, ['destroy']
  end


  def test_regex_pattern
    @permission.controller(:users)

    assert_equal @permission.regex_pattern, "(\/users(\/.*)?)"
  end

  def test_regex_pattern_with_multiple_controllers
    @permission.controller(:users)
    @permission.controller(:posts)

    assert_equal @permission.regex_pattern, "(\/users(\/.*)?)|(\/posts(\/.*)?)"
  end
end

