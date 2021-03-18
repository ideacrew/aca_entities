# frozen_string_literal: true

module Ehs
  class People::Person < Dry::Struct
    attribute :identifiers,         Types::Array.of(Identifiers::Id).meta(omittable: false)
    attribute :ssn,                 Types::String.optional.meta(omittable: true)
    attribute :relationship,        Types::String.optional.meta(omittable: true)
    attribute :gender,              Types::GenderKinds.meta(omittable: false)
    attribute :date_of_birth,       Types::Date.meta(omittable: false)
    attribute :person_name,         People::PersonName
    attribute :last_updated_at,     Types::DateTime.meta(omittable: false)
    attribute :contact_information, Types::Array.of(Ehs::People::ContactInformation).meta(omittable: true)
  end
end
