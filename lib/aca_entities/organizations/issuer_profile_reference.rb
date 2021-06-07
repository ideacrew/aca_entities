# frozen_string_literal: true

module AcaEntities
  module Organizations
    class IssuerProfileReference < Dry::Struct

      attribute :hbx_id,               Types::Strict::String.optional.meta(omittable: false)
      attribute :hbx_carrier_id,       Types::Strict::String.optional.meta(omittable: false)
      attribute :name,                 Types::Strict::String.meta(omittable: false)
      attribute :fein,                 Types::Strict::String.optional.meta(omittable: true)
      attribute :abbrev,               Types::Strict::String.optional.meta(omittable: false)
      attribute :is_active,            Types::Bool.optional.meta(omittable: true)
    end
  end
end