# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for VerificationHeader
      class VerificationHeader < Dry::Struct
        attribute :verification_date,       Types::Date
        attribute :verified_by,             Types::String
        attribute :medicaid_chip_state,     Types::String.optional.meta(omittable: true)
        attribute :medicaid_chip_county,    Types::String.optional.meta(omittable: true)
        attribute :verification_type,       Types::String.optional.meta(omittable: true)
        attribute :verification_source,     Types::String.optional.meta(omittable: true)
        attribute :verification_status,     Types::String
        attribute :verification_code,       Types::String.optional.meta(omittable: true)
        attribute :response_code,           Types::String.optional.meta(omittable: true)
      end
    end
  end
end
