# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Transactions
        # contract for curam transactions
        class TransactionContract < Curam::ApplicationContract

          params do
            required(:kind).filled(:string)
            required(:message).filled(:string)
            required(:operation_name).filled(:string)
            optional(:correlation_id).maybe(:string)
            optional(:title).maybe(:string)
            optional(:description).maybe(:string)
            optional(:variances).maybe(:array)
            optional(:reference_id).maybe(:string)
            optional(:object_id).maybe(:string)
            optional(:object_type).maybe(:string)
            optional(:entity_name).maybe(:string)
            optional(:event_name).maybe(:string)
          end

          rule(:kind) do
            key.failure(text: 'invalid kind') if key? && value && !Transactions::TransactionRecord::KINDS.include?(value)
          end
        end
      end
    end
  end
end
