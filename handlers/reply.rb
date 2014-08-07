module Lita
  module Handlers
    class Reply < Handler
      route /大丈夫？/, :all_right

      def all_right(message)
        return unless message.user.metadata["mention"]
        message.reply "@#{message.user.name} 榛名は大丈夫です！"
      end
    end

    Lita.register_handler(Reply)
  end
end
