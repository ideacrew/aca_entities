module Ehs
  module Comments
    module Events
      class CommentAdded < Sequent::Event
        attrs aggregate_id: String, comment: Ehs::Comments::CommentValueObject, commentable_id: String, commentable_type: String
      end

      class CommentUpdated < Sequent::Event
        attrs aggregate_id: String, comment: Ehs::Comments::CommentValueObject, commentable_id: String, commentable_type: String
      end
    end
  end
end


