module Guacamole
  module Proxies
    class Proxy
      # We undefine most methods to get them sent through to the target.
      instance_methods.each do |method|
        undef_method(method) unless method =~ /(^__|^send|^object_id|^respond_to|^tap)/
      end

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
