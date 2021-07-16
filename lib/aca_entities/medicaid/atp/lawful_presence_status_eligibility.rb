# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp LawfulPresenceStatusEligibility
      class LawfulPresenceStatusEligibility < Dry::Struct

        attribute :eligibility_indicator, Types::Bool.meta(omittable: false)
        attribute :eligibility_basis_status_code, Types::String.optional.meta(omittable: true)
      end
    end
  end
end