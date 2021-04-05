# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for CurrentIncomeEmployer
      class CurrentIncomeEmployer < Dry::Struct
        attribute :street_1, Types::String.optional.meta(omittable: true)
        attribute :street_2, Types::String.optional.meta(omittable: true)
        attribute :city, Types::String.optional.meta(omittable: true)
        attribute :state_code, Types::String.optional.meta(omittable: true)
        attribute :zip_code, Types::String.optional.meta(omittable: true)
      end
    end
  end
end
