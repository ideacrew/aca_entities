# frozen_string_literal: true

module Ehs
  class Phones::Phone < Dry::Struct

    attribute :type,              Types::PhoneKind.meta(omittable: false)
    attribute :area_code,         Types::String.optional.meta(omittable: true)
    attribute :phone_number,      Types::String.meta(omittable: false)
    attribute :full_phone_number, Types::String.optional.meta(omittable: true)
    attribute :is_preferred,      Types::Bool.meta(omittable: false)
  end
end
