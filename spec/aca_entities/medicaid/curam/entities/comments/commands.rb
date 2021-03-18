module Ehs
  module Comments
    module Commands

      class AddComment < Sequent::Command
        attrs comment: CommentValueObject
      end
      
      class UpdateComment < Sequent::Command
        attrs comment: CommentValueObject
      end
    end
  end
end
