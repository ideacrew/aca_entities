# frozen_string_literal: true

module AcaEntities
  module Contacts
    class PhoneContact < Dry::Struct

      attribute :kind, AcaEntities::Types::PhoneKind.meta(omittable: false)
      attribute :country_code, Types::String.optional.meta(omittable: true)
      attribute :area_code, Types::String.optional.meta(omittable: false)
      attribute :number, Types::String.optional.meta(omittable: false)
      attribute :extension, Types::String.optional.meta(omittable: true)
      attribute :primary, Types::Bool.optional.meta(omittable: false)
      attribute :full_phone_number, Types::String.optional.meta(omittable: true)
      attribute :start_on, Types::Date.optional.meta(omittable: true)
      attribute :end_on, Types::Date.optional.meta(omittable: true)
    end
  end
end
