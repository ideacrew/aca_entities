# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Comments
        module Commands
          # add comment command
          class AddComment < Sequent::Command
            attrs comment: CommentValueObject
          end

          # update comment command
          class UpdateComment < Sequent::Command
            attrs comment: CommentValueObject
          end
        end
      end
    end
  end
end
