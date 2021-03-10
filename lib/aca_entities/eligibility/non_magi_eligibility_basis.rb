# frozen_string_literal: true

module AcaEntities
  module Eligibility
    class NonMagiEligibilityBasis < Dry::Struct

      attribute :person_disabled,                   Types::Bool.optional.meta(omittable: true)
      attribute :person_disable_status_code,        Types::String.optional.meta(omittable: true)
      attribute :medicare_entitlement,              Types::Bool.optional.meta(omittable: true)
      attribute :medicare_entitlement_status_code,  Types::String.optional.meta(omittable: true)

    end
  end
end
