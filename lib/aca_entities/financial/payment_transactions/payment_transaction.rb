# frozen_string_literal: true

module AcaEntities
  module Financial
    module PaymentTransactions
      class PaymentTransaction < Dry::Struct
        transform_keys(&:to_sym)

        attribute :enrollment_id,                Types::Strict::String.meta(omittable: false)
        attribute :carrier_id,                   Types::Strict::String.meta(omittable: false)
        # TODO: Needs refactor to
        # attribute :issuer_profile_reference,     AcaEntities::Organizations::IssuerProfileReference.meta(omittable: false)
        attribute :enrollment_effective_date,    Types::Strict::Date.meta(omittable: false)

        attribute :payment_transaction_id,       Types::String.optional.meta(omittable: true)
        attribute :status,                       Types::String.optional.meta(omittable: true)

      end
    end
  end
end