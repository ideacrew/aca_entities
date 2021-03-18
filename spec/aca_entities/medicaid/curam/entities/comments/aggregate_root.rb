module Ehs
  module Comments
    class AggregateRoot < Sequent::AggregateRoot

      def initialize(command)
        super(command.aggregate_id)
        apply Events::CommentAdded, comment: command.comment
      end

      def update(command)
        apply Events::CommentUpdated, comment: command.comment
      end

      on Events::CommentAdded do |event|
        @comment = event.comment
      end

      on Events::CommentUpdated do |event|
        @comment = event.comment
      end
    end
  end
end
