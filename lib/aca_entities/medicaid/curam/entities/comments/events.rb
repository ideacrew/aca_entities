# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Comments
        module Events
          # event for comment add
          class CommentAdded < Sequent::Event
            attrs aggregate_id: String, comment: Curam::Comments::CommentValueObject, commentable_id: String, commentable_type: String
          end

          # event for comment update
          class CommentUpdated < Sequent::Event
            attrs aggregate_id: String, comment: Curam::Comments::CommentValueObject, commentable_id: String, commentable_type: String
          end
        end
      end
    end
  end
end
