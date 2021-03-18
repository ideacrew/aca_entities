# frozen_string_literal: true

module Ehs
  class People::ContactInformation < Dry::Struct

    attribute :addresses, Types::Array.of(Ehs::Addresses::Address).meta(omittable: false)
    attribute :phones,    Types::Array.of(Ehs::Phones::Phone).meta(omittable: false)
    attribute :emails,    Types::Array.of(Ehs::Emails::Email).optional.meta(omittable: true)
  end
end
