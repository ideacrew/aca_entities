# frozen_string_literal: true

module AcaEntities
  class Phone < Dry::Struct

    attribute :kind, Types::String.optional
    attribute :country_code, Types::String.optional.meta(omittable: true)
    attribute :area_code, Types::String.optional.meta(omittable: true)
    attribute :number, Types::String.optional.meta(omittable: true)
    attribute :extension, Types::String.optional.meta(omittable: true)
    attribute :primary, Types::Strict::Bool.meta(omittable: true)
    attribute :full_phone_number, Types::String.optional
  end
end
