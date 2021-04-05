# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp ChipUnbornChildCategoryBasis
      class ChipUnbornChildCategoryBasis < Dry::Struct

        attribute :category_code,         Types::String.meta(omittable: false)
        attribute :category_indicator,    Types::Bool.optional.meta(omittable: true)
        attribute :determination_date,    Types::Date.optional.meta(omittable: true)
        attribute :ineligibility_reason,  Types::String.optional.meta(omittable: true)

      end
    end
  end
end
