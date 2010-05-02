# encoding: utf-8

module Monty
  module Access
    # Define permision that defines how your application is accessed. 
    #     # All methods on the site controller will be open to users who have
    #     # this permission.
    #     permission :public_pages do
    #       controller :site
    #     end
    #
    #     # Can use multiple controller statements
    #     permission :public_pages do
    #       controller :site
    #       controller :posts
    #     end
    #
    #     # Only methods show, edit and update on the users controller will 
    #     # be open to users who have this permission.
    #     permission :my_account_pages do
    #       controller :users  do
    #         only :show, :edit, :update
    #       end
    #     end
    #
    #     # All methods except destroy on the users controller will be 
    #     # open to users who have this permission.
    #     permission :manage_users do
    #       controller :users  do
    #         except :destroy
    #       end
    #     end
    #
    # @param [String,Symbol] name permission reference. 
    # @yield [Monty::Permission.new(name)] new permission object
    def permission(name, &block)
      permission =  Monty::Permission.new(name)   
      if block_given?
        permission.instance_eval(&block) 
      else
        permission.controller(permission.name)
      end
      Monty::Configuration.permissions << permission
      permission
    end
  end # Access
end # Monty
