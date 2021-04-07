# frozen_string_literal: true

module AcaEntities
  module Determinations
    # records transitions from consumer role to resident role eligibility
    class IndividualMarketTransition < Dry::Struct
      attribute :role_type,                      Types::String.meta(omittable: false)
      attribute :start_on,                       Types::Date.optional.meta(omittable: false)
      attribute :end_on,                         Types::Date.optional.meta(omittable: false)
      attribute :reason_code,                    Types::String.meta(omittable: false)
      attribute :submitted_at,                   Types::Date.meta(omittable: false)
    end
  end
end
