# frozen_string_literal: true

module Qbo::Locations
  class Address < Dry::Struct

    attribute :"Id",                        Types::String.meta(omittable: true)
    attribute :"Line1",                     Types::String.meta(omittable: true)
    attribute :"City",                      Types::String.meta(omittable: true)
    attribute :"PostalCode",                Types::String.meta(omittable: true)
    attribute :"Lat",                       Types::String.meta(omittable: true)
    attribute :"Long",                      Types::String.meta(omittable: true)
    attribute :"CountrySubDivisionCode",    Types::String.meta(omittable: true)
  end
end
