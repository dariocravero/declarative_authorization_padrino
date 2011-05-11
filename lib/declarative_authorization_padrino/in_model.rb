# Authorization::AuthorizationInModel
module Authorization
  module AuthorizationInModel
    def self.included(base) # :nodoc:
      base.module_eval do
        # Activates model security for the current model.  Then, CRUD operations
        # are checked against the authorization of the current user.  The
        # privileges are :+create+, :+read+, :+update+ and :+delete+ in the
        # context of the model.  By default, :+read+ is not checked because of
        # performance impacts, especially with large result sets.
        # 
        #   class User < ActiveRecord::Base
        #     using_access_control
        #   end
        #   
        # If an operation is not permitted, a Authorization::AuthorizationError
        # is raised.
        #
        # To activate model security on all models, call using_access_control
        # on ActiveRecord::Base
        #   ActiveRecord::Base.using_access_control
        # 
        # Available options
        # [:+context+] Specify context different from the models table name.
        # [:+include_read+] Also check for :+read+ privilege after find.
        #
        def self.using_access_control (options = {})
          options = {
            :context => nil,
            :include_read => false
          }.merge(options)

          class_eval do
            [:create, :update, [:destroy, :delete]].each do |action, privilege|
              send(:"before_#{action}") do |object|
                Authorization::Engine.instance.permit!(privilege || action,
                  :object => object, :context => options[:context])
              end
            end
            
            if options[:include_read]
              # after_find is only called if after_find is implemented
              after_find do |object|
                Authorization::Engine.instance.permit!(:read, :object => object,
                  :context => options[:context])
              end
            end

            def self.using_access_control?
              true
            end
          end
        end
      end
    end
  end
end
