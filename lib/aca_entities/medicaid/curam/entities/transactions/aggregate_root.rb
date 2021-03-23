# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Transactions
        # curam Transactions AggregateRoot
        class AggregateRoot < Sequent::AggregateRoot

          def initialize(command)
            super(command.aggregate_id)

            apply Events::TransactionCreated, transaction: command.transaction

            command.transaction.variances.each do |variance|
              apply Curam::Variances::Events::VarianceCreated,
                    {
                      variance: variance,
                      transaction_record_id: command.aggregate_id
                    }

              variance.comments.each do |comment|
                apply Curam::Comments::Events::CommentAdded,
                      {
                        comment: comment,
                        commentable_id: variance.aggregate_id,
                        commentable_type: 'Curam::Variances::VarianceRecord'
                      }
              end
            end
          end

          def update(command)
            apply Events::TransactionUpdated, transaction: command.transaction
          end

          on Events::TransactionCreated do |event|
            @transaction = event.transaction
          end

          on Events::TransactionUpdated do |event|
            @transaction = event.transaction
          end

          on Curam::Variances::Events::VarianceCreated do |event|
            @variance = event.variance
            @transaction_record_id = event.transaction_record_id
          end

          on Curam::Comments::Events::CommentAdded do |event|
            @comment = event.comment
            @commentable_id = event.commentable_id
            @commentable_type = event.commentable_type
          end
        end
      end
    end
  end
end
