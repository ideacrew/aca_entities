# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for MedicaidSpecificInformation.
      class MedicaidSpecificInformation < Dry::Struct

        attribute :medical_bills_in_last_90_days,   Types::Bool.optional.meta(omittable: true)
      end
    end
  end
end
