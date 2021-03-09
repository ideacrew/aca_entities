# frozen_string_literal: true

module AcaEntities
  module PaymentTransactions
    class Transaction < Dry::Struct
      transform_keys(&:to_sym)

      attribute :enrollment_id,                Types::Strict::String
      attribute :carrier_id,                   Types::Strict::String
      attribute :enrollment_effective_date,    Types::Strict::Date
    end
  end
end