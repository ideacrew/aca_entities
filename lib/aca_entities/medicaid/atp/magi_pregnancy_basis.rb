# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp MagiPregnancyBasis
      class MagiPregnancyBasis < Dry::Struct

        attribute :category_code,            Types::String.meta(omittable: false)
        attribute :category_indicator,       Types::Bool.optional.meta(omittable: true)
        attribute :ineligibility_reason,     Types::String.optional.meta(omittable: true)
        attribute :determination_date,       Types::DateTime.optional.meta(omittable: true)

      end
    end
  end
end
