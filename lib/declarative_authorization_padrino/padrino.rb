module Authorization
  module Padrino
    def self.registered(app)
      app.extend(Protect)
      def app.hide_action(*args); end; #stub this method since it belongs to rails' controllers
      app.helpers Authorization::AuthorizationInController
    end

    module Protect
      def protect(*args)
        condition {
          unless permitted_to? args[0][:action], args[0][:resource]
            halt 403, args[0][:forbidden] || "Can't access this"
          end
        }
      end
    end

    # Include this module in your helpers if you don't have an auth system that provides them :)
    module CurrentUser
      def current_user
        Authorization.current_user
      end
      def current_user=(user)
        Authorization.current_user=user
      end
    end
  end
end
