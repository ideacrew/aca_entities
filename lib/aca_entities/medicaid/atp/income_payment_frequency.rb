# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp IncomePaymentFrequency
      class IncomePaymentFrequency < Dry::Struct

        attribute :frequency_code, Types::String.optional.meta(omittable: true)
      end
    end
  end
end