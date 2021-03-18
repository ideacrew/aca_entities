# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for CurrentDeductionInformation
      class CurrentDeductionInformation < Dry::Struct
        attribute :category_code, Types::String.optional.meta(omittable: false)
        attribute :amount, Types::Float.optional.meta(omittable: false)
        attribute :frequency_code, Types::String.optional.meta(omittable: false)
        attribute :category_text, Types::String.optional.meta(omittable: false)
      end
    end
  end
end
