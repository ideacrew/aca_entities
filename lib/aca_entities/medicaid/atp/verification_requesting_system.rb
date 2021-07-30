# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for VerificationRequestingSystem
      class VerificationRequestingSystem < Dry::Struct
        attribute :id,                   Types::String.meta(omittable: false)
        attribute :category_code,        Types::InformationExchangeSystemCategoryCode.meta(omittable: false)
        attribute :state_code,           Types::String.optional.meta(omittable: true)
        attribute :county_name,          Types::String.optional.meta(omittable: true)
      end
    end
  end
end