# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp IncomePaymentFrequency
      class IncomePaymentFrequency < Dry::Struct

        attribute :frequency_code, Types::FrequencyCode.meta(omittable: false)
      end
    end
  end
end