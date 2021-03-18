# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp ExchangeVerifiedPresenceBasis
      class ExchangeVerifiedPresenceBasis < Dry::Struct

        attribute :status_code,           Types::String.meta(omittable: false)
        attribute :status_indicator,      Types::Bool.optional.meta(omittable: true)
        attribute :determination_date,    Types::DateTime.optional.meta(omittable: true)
        attribute :inconsistency_reason,  Types::String.optional.meta(omittable: true)

      end
    end
  end
end
