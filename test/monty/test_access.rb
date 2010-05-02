require 'helper'

class TestModel
  include Monty::Access
end

class TestMontyAccess < Test::Unit::TestCase

  def setup
    @model = TestModel.new
  end

  def teardown
    Monty::Configuration.reset
  end

  def test_model_responds_to_permission
    assert_respond_to @model, :permission
  end

  def test_permission_with_single_controller
    perm = @model.permission(:my_perm) do 
              controller :my_controller
           end

    controller = perm.controllers.first
    assert_equal 'my_controller', controller.name
    assert_equal "\/my_controller\/.*", controller.regex_pattern
  end

  def test_permission_without_block
    perm = @model.permission(:users) 

    controller = perm.controllers.first
    assert_equal 'users', controller.name
    assert_equal "\/users\/.*", controller.regex_pattern
  end
end

