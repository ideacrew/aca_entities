# frozen_string_literal: true

module AcaEntities
  module Contacts
    class PhoneContact < Dry::Struct

      attribute :kind, Types::String
      attribute :country_code, Types::String.optional.meta(omittable: true)
      attribute :area_code, Types::String.optional.meta(omittable: true)
      attribute :number, Types::String.optional.meta(omittable: true)
      attribute :extension, Types::String.optional.meta(omittable: true)
      attribute :primary, Types::Strict::Bool.meta(omittable: true)
      attribute :full_phone_number, Types::String.optional
      attribute :start_on, Types::Date.optional.meta(omittable: true)
      attribute :end_on, Types::Date.optional.meta(omittable: true)
    end
  end
end
