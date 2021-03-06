# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp RefugeeMedicalAssistanceEligibilityHeader
      class RefugeeMedicalAssistanceEligibilityHeader < Dry::Struct

        attribute :status_indicator,                  Types::Bool.optional.meta(omittable: true)
        attribute :determination_date,                Types::DateTime.optional.meta(omittable: true)
        attribute :ineligibility_reason,              Types::String.optional.meta(omittable: true)
        attribute :start_date,                        Types::Date.meta(omittable: false)
        attribute :end_date,                          Types::Date.optional.meta(omittable: true)
        attribute :medicaid_chip_state,               Types::String.meta(omittable: false)
        attribute :medicaid_chip_county,              Types::String.optional.meta(omittable: true)
        attribute :eligibility_establishment_system,  Types::String.optional.meta(omittable: true)

      end
    end
  end
end
