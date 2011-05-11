module Authorization
  AUTH_DSL_FILES = [Pathname.new(PADRINO_ROOT || '').join("config", "authorization_rules.rb").to_s] unless defined? AUTH_DSL_FILES

  def self.activate_authorization_rules_browser? # :nodoc:
    ::Padrino.env == :development
  end

  class Engine
    # Returns the role symbols of the given user.
    def roles_for (user)
      user ||= Authorization.current_user
      raise AuthorizationUsageError, "User object doesn't respond to roles (#{user.inspect})" \
        if !user.respond_to?(:role_symbols) and !user.respond_to?(:roles)

      ::Padrino.logger.info("The use of user.roles is deprecated.  Please add a method " +
          "role_symbols to your User model.") if defined?(::Padrino) and ::Padrino.respond_to?(:logger) and !user.respond_to?(:role_symbols)

      roles = user.respond_to?(:role_symbols) ? user.role_symbols : user.roles

      raise AuthorizationUsageError, "User.#{user.respond_to?(:role_symbols) ? 'role_symbols' : 'roles'} " +
        "doesn't return an Array of Symbols (#{roles.inspect})" \
            if !roles.is_a?(Array) or (!roles.empty? and !roles[0].is_a?(Symbol))

      (roles.empty? ? [Authorization.default_role] : roles)
    end
  end
end
