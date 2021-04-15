# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Comments
        # CommentValueObject
        class CommentValueObject < Sequent::ValueObject
          attrs aggregate_id: String, content: String, is_priority: Boolean, priority: String, updated_by: String, commentable_id: String,
                commentable_type: String
        end
      end
    end
  end
end