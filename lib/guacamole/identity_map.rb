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
      end

      def retrieve(object)
        identity_map_instance[key_for(object)]
      end

      def include?(object)
        identity_map_instance.key? key_for(object)
      end

      def identity_map_instance
        @identity_map_instance ||= Hamster.hash
      end

      def key_for(object)
        [object.class, object.key]
      end
    end
  end
end
