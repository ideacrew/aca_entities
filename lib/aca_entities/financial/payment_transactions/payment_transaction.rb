# frozen_string_literal: true

module AcaEntities
  module Financial
    module PaymentTransactions
      class PaymentTransaction < Dry::Struct

        attribute :payment_transaction_id,       Types::String.optional.meta(omittable: true)
        attribute :enrollment_id,                Types::Strict::String.meta(omittable: false)
        attribute :issuer_profile,               AcaEntities::Organizations::IssuerProfileReference.meta(omittable: false)
        attribute :enrollment_effective_date,    Types::Strict::Date.meta(omittable: false)
        attribute :status,                       Types::String.optional.meta(omittable: false)
      end
    end
  end
end