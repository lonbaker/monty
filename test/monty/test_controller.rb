require 'helper'

class TestMontyController < Test::Unit::TestCase

  def setup
    @controller = Monty::Controller.new(:users)
  end

  def test_initializer_sets_correct_state
    assert_equal @controller.name, 'users'
    assert_equal @controller.regex_pattern, "\/users\/.*"
  end

  def test_except_sets_correct_regex_pattern
    @controller.except(:destroy)
    assert_equal @controller.regex_pattern, "\/users\/(?!(destroy)).*"
  end

  def test_except_with_multiple_params_sets_correct_regex_pattern
    @controller.except(:index, :destroy)
    assert_equal @controller.regex_pattern, "\/users\/(?!(index|destroy)).*"
  end

  def test_except_with_no_params_preserves_regex_pattern
    controller = Monty::Controller.new(:users)
    controller.except()
    assert_equal controller.regex_pattern, "\/users\/.*"
  end

  def test_only_sets_correct_regex_pattern
    @controller.only(:index)
    assert_equal @controller.regex_pattern, "\/users\/(index)"
  end

  def test_only_with_multiple_params_sets_correct_regex_pattern
    @controller.only(:show, :edit)
    assert_equal @controller.regex_pattern, "\/users\/(show|edit)"
  end

  def test_only_with_no_params_preserves_regex_pattern
    controller = Monty::Controller.new(:users)
    controller.only()
    assert_equal controller.regex_pattern, "\/users\/.*"
  end

end

