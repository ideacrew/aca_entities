# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Transactions
        # entity for TransactionSet
        class TransactionSet < Dry::Struct

          attribute :ids,               Types::Array.of(Curam::Identifiers::Id).optional.meta(omittable: true)
          attribute :kind,              Types::String.meta(omittable: false) # controller name
          attribute :header,            Types::String.meta(omittable: true)
          attribute :message,           Types::String.meta(omittable: false)
          attribute :transactions,      Types::Array.of(Curam::Transactions::Transaction).meta(omittable: true)
          attribute :response_code,     Types::Integer.meta(omittable: false)
          attribute :response_message,  Types::String.meta(omittable: true)
          attribute :created_at,        Types::DateTime.meta(omittable: false)
          attribute :updated_at,        Types::DateTime.meta(omittable: false)
        end
      end
    end
  end
end