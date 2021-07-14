# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp LawfulPresenceStatusEligibility
      class LawfulPresenceStatusEligibility < Dry::Struct

        attribute :eligibility_indicator, Types::Bool.meta(omittable: false)
      end
    end
  end
end
