# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp address
      class Address < Dry::Struct
        attribute :fixed_address_indicator,          Types::Bool.meta(omittable: false)
        attribute :address_type_code,                Types::String.optional.meta(omittable: true)
        attribute :street_name_1,                    Types::String.optional.meta(omittable: true)
        attribute :street_name_2,                    Types::String.optional.meta(omittable: true)
        attribute :city_name,                        Types::String.optional.meta(omittable: true)
        attribute :state_code,                       Types::String.optional.meta(omittable: true)
        attribute :zip_code,                         Types::String.optional.meta(omittable: true)
        attribute :county_name,                      Types::String.optional.meta(omittable: true)
        attribute :county_code,                      Types::String.optional.meta(omittable: true)
        attribute :lives_outside_state_temporarily,  Types::Bool.optional.meta(omittable: true)
        attribute :address_validation_status,        Types::String.optional.meta(omittable: true)
      end
    end
  end
end
