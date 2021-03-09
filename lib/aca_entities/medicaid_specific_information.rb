# frozen_string_literal: true

module AcaEntities
  # Entity for MedicaidSpecificInformation.
  class MedicaidSpecificInformation < Dry::Struct

    attribute :medical_bills_in_last_90_days,   Types::Bool.optional.meta(omittable: true)
  end
end
