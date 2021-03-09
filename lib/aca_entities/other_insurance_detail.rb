# frozen_string_literal: true

module AcaEntities
  # Entity for OtherInsuranceDetail.
  class OtherInsuranceDetail < Dry::Struct

    attribute :type_code,       Types::String.optional.meta(omittable: true)
    attribute :insurance_name,  Types::String.optional.meta(omittable: true)
    attribute :policy_number,   Types::String.optional.meta(omittable: true)
  end
end
