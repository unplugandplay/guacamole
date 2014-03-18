# -*- encoding : utf-8 -*-

require 'hamster/hash'

module Guacamole
  class IdentityMap
    class Session
      def initialize(app)
        @app = app
      end

      def call(env)
        Guacamole.logger.debug '[SESSION] Resetting the IdentityMap'
        IdentityMap.reset

        @app.call(env)
      end
    end

    class << self
      def reset
        @identity_map_instance = nil
      end

      def store(object)
        @identity_map_instance = identity_map_instance.put(key_for(object), object)
        object
      end

      def retrieve(klass, key)
        identity_map_instance.get key_for(klass, key)
      end

      def retrieve_or_store(klass, key, &block)
        return retrieve(klass, key) if include?(klass, key)

        store block.call
      end

      def include?(object_or_class, key = nil)
        identity_map_instance.key? key_for(object_or_class, key)
      end

      def key_for(object_or_class, key = nil)
        key ? [object_or_class, key] : [object_or_class.class, object_or_class.key]
      end

      def identity_map_instance
        @identity_map_instance ||= Hamster.hash
      end
    end
  end
end
