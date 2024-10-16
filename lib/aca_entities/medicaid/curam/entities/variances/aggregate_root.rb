# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Variances
        # AggregateRoot Variance
        class AggregateRoot < Sequent::AggregateRoot

          def initialize(command)
            super(command.aggregate_id)
            apply Events::VarianceCreated, variance: command.variance

            command.variance.comments.each do |comment|
              apply Curam::Comments::Events::CommentAdded,
                    {
                      comment: comment,
                      commentable_id: command.aggregate_id,
                      commentable_type: 'Curam::Variances::VarianceRecord'
                    }
            end
          end

          def update(command)
            apply Events::VarianceUpdated, variance: command.variance
          end

          def close(command)
            apply Events::VarianceClosed, updated_by: command.updated_by
          end

          on Events::VarianceCreated do |event|
            @variance = event.variance
          end

          on Events::VarianceUpdated do |event|
            @variance = event.variance
          end

          on Events::VarianceClosed do |event|
            @updated_by = event.updated_by
          end

          on Curam::Comments::Events::CommentAdded do |event|
            @comment = event.comment,
                       @commentable_id = event.commentable_id,
                       @commentable_type = event.commentable_type
          end
        end
      end
    end
  end
end
