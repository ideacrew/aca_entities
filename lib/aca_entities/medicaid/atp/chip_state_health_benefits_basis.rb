# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp ChipStateHealthBenefitsBasis
      class ChipStateHealthBenefitsBasis < Dry::Struct

        attribute :status_code,           Types::String.meta(omittable: false)
        attribute :status_indicator,      Types::Bool.optional.meta(omittable: true)
        attribute :determination_date,    Types::DateTime.optional.meta(omittable: true)
        attribute :ineligibility_reason,  Types::String.optional.meta(omittable: true)

      end
    end
  end
end
