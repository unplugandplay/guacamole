require 'guacamole/proxies/proxy'

module Guacamole
  module Proxies
    class ReferencedBy < Proxy
      def initialize(ref, model)
        init model, -> { "::#{ref.to_s.pluralize.camelcase}Collection".constantize.by_example("#{model.class.name.underscore}_id" => model.key) }
      end
    end
  end
end
