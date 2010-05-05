require 'helper'

class TestMontyAccess < Test::Unit::TestCase
  include Monty::Access

  def teardown
    Monty::Configuration.reset
  end

  def test_model_responds_to_permission
    assert_respond_to self, :permission
  end

  def test_permission_with_single_controller
    perm = permission(:my_perm) do 
              controller :my_controller
           end

    controller = perm.controllers.first
    assert_equal 'my_controller', controller.name
    assert_equal "\/my_controller(\/.*)?", controller.regex_pattern
  end

  def test_permission_without_block
    perm = permission(:users) 

    controller = perm.controllers.first
    assert_equal 'users', controller.name
    assert_equal "\/users(\/.*)?", controller.regex_pattern
  end

  def test_public_access
    permission(:site)
    public_access :site

    assert_equal Monty::Configuration.public_access, "(\/site(\/.*)?)"
  end

  def test_public_access_with_multiple_permissions
    permission(:site)
    permission(:registration)
    permission(:view_posts)
    public_access :site, :registration, :view_posts

    assert_equal Monty::Configuration.public_access, 
      "(\/site(\/.*)?)|(\/registration(\/.*)?)|(\/view_posts(\/.*)?)"
  end

  def test_protected_access
    permission(:my_account)
    protected_access :my_account

    assert_equal Monty::Configuration.protected_access, "(\/my_account(\/.*)?)"
  end

  def test_protected_access_with_multiple_permissions
    permission(:my_account)
    permission(:edit_posts)
    protected_access :my_account, :edit_posts

    assert_equal Monty::Configuration.protected_access, 
      "(\/my_account(\/.*)?)|(\/edit_posts(\/.*)?)"
  end


end

