# frozen_string_literal: true

module Ehs
  class People::PersonName < Dry::Struct

    attribute :last_name,     Types::String.meta(omittable: false)
    attribute :first_name,  Types::String.meta(omittable: false)
    attribute :middle_name, Types::String.optional.meta(omittable: true)
    attribute :name_pfx,    Types::String.optional.meta(omittable: true)
    attribute :name_sfx,    Types::String.optional.meta(omittable: true)

    def full_name
    [name_pfx, first_name, middle_name, last_name, name_sfx].compact.join(" ")
    end
  end
end
