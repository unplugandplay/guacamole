# -*- encoding : utf-8 -*-

require 'hamster/hash'

module Guacamole
  class IdentityMap
    class << self
      def reset
        @identity_map_instance = nil
      end

      def store(object)
        @identity_map_instance = identity_map_instance.put(key_for(object), object)
        object
      end

      def retrieve(object_or_class, key = nil)
        identity_map_instance[key_for(object_or_class, key)]
      end

      def fetch(klass, key, &block)
        if include?(klass, key)
          return retrieve klass, key
        end

        store block.call
      end

      def include?(object_or_class, key = nil)
        identity_map_instance.key? key_for(object_or_class, key)
      end

      def identity_map_instance
        @identity_map_instance ||= Hamster.hash
      end

      def key_for(object_or_class, key = nil)
        if key
          [object_or_class, key]
        else
          [object_or_class.class, object_or_class.key]
        end
      end
    end
  end
end
