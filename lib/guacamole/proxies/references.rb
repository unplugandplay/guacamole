require 'guacamole/proxies/proxy'

module Guacamole
  module Proxies
    class References < Proxy
      def initialize(ref, document)
        init nil, -> { "::#{ref.to_s.pluralize.camelcase}Collection".constantize.by_key(document["#{ref}_id"]) }
      end
    end
  end
end
