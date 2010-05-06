= monty
Rack based authorization system.

[Yard docs](http://yardoc.org/docs/stonean-monty)

More to come, but here's the gist for rails 2.3.5:

In your environment.rb add:

    require 'monty'
    config.middleware.insert_after ActionController::ParamsParser, Monty::Watch

There may be other positions in the middleware stack that will work, I've tested this one.

Then you'll need to define your access rules.  Create a file called authorization.rb in app/models. 

Here's an example:

    class Authorization
      extend Monty::Access
  
      # This is creates the following regex matching: \/posts(\/.*)?
      # Allows: /posts, /posts/, /posts/<any method>
      permission 'posts'

      # This is creates the following regex matching: \/posts(?!\/(destroy))(\/.*)?
      # Not allowed: /posts/destroy
      # Allows: /posts, /posts/, /posts/<any method but destroy>
      permission 'posts' do
        controller 'posts' do
          except 'destroy'
        end
      end

      # This is creates the following regex matching: \/posts\/(show|edit|update)
      # Only allows: /posts/show, /posts/edit and /posts/update
      permission 'posts' do
        controller 'posts' do
          only 'show', 'edit', 'update'
        end
      end
    
      # Permissions can have more than one controller
      permission 'public' do
        controller 'posts'
        controller 'welcome'
        controller 'feeds'
      end

      # To make one of the above permissions public
      public_access 'public'

      # To make one of the above permissions protected
      protected_access 'public'
    end


Monty only has the concept of public and protected right now.  After you have authenticated your user, you'll need to have some code in your controller that looks like:

  session[:access_rights] = Monty.authenticated_access

Don't forget to reset your session when the user logs out.

Ummm, I think that's it for now.  Let me know if you have any questions.  

This project is the replacement for Lockdown.

== Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

== Copyright

Copyright (c) 2010 Andrew Stone. See LICENSE for details.
