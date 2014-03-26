module Guacamole
  module Proxies
    # This is the base class for the association proxies. Proxies are only
    # needed for non-embedded relations between objects. Embedded objects are
    # taken care of by Virtus.
    #
    # The `Proxy` class undefines most methods and passes them to the
    # `@target`.  The `@target` will be a lambda which will lazy query the
    # requested objects from the database.
    #
    # Concrete proxy classes are:
    #
    #  * {Guacamole::Proxies::ReferencedBy}: This will handle one-to-many associations
    #  * {Guacamole::Proxies::References}: This will handle many-to-one associations
    class Proxy
      # We undefine most methods to get them sent through to the target.
      instance_methods.each do |method|
        undef_method(method) unless method =~ /(^__|^send|^object_id|^respond_to|^tap)/
      end

      # Convenience method to setup the proxy. The subclasses need to care of creating
      # the `target` correctly.
      #
      # @param [Object] base The class holding the reference. Currently not used.
      # @param [#call] target The lambda for getting the required objects from the database.
      def init(base, target)
        @base = base
        @target = target
      end

      protected

      def method_missing(meth, *args, &blk)
        @target.call.send meth, *args, &blk
      end
    end
  end
end
