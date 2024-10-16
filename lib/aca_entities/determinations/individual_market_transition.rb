# frozen_string_literal: true

module AcaEntities
  module Determinations
    # records transitions from consumer role to resident role eligibility
    class IndividualMarketTransition < Dry::Struct
      attribute :role_type,                      AcaEntities::Types::MarketTransitionRoleTypes.meta(omittable: false)
      attribute :start_on,                       Types::Date.optional.meta(omittable: false)
      attribute :end_on,                         Types::Date.optional.meta(omittable: false)
      attribute :reason_code,                    AcaEntities::Types::MarketTransitionReasonCodes.meta(omittable: false)
      attribute :submitted_at,                   Types::DateTime.meta(omittable: false)
    end
  end
end
