require "active_support/core_ext/module/delegation" # for some funny reason I need this here! ActiveRecord might not be pulling it from its dependencies?

require File.join("declarative_authorization_padrino", "authorization")

module Rails
  def self.version 
    "3"
  end
end

require "declarative_authorization/helper"
require File.join("declarative_authorization_padrino", "in_model")
require "declarative_authorization/in_controller"
require "declarative_authorization/in_model"
require "declarative_authorization/obligation_scope"

ActiveRecord::Base.send :include, Authorization::AuthorizationInModel

require File.join("declarative_authorization_padrino", "padrino")
