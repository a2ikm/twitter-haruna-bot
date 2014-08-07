module Lita
  module Extensions
    module Deregister
      def deregister_handler(handler_or_key)
        namespace =
          if handler_or_key.respond_to?(:namespace)
            handler_or_key.namespace
          else
            handler_or_key
          end

        handlers.delete_if do |handler|
          handler.namespace == namespace
        end
      end
    end
  end

  extend Extensions::Deregister
end
