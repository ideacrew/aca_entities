# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module MecCheck
      # entity for RequestedInsurancePeriod
      class RequestedInsurancePeriod < Dry::Struct
        attribute :start_date, Types::Date.meta(omittable: false)
        attribute :end_date, Types::Date.meta(omittable: false)
      end
    end
  end
end