# frozen_string_literal: true

module AcaEntities
  # Entity for AuthorizedRepresentative
  class AuthorizedRepresentative < Dry::Struct
    attribute :first_name,       Types::Integer.optional.meta(omittable: true)
    attribute :middle_name,      Types::String.optional.meta(omittable: true)
    attribute :last_name,        Types::String
    attribute :suffix,           Types::String.optional.meta(omittable: true)
    attribute :legal_name,       Types::String.optional.meta(omittable: true)
    attribute :fein,             Types::String.optional.meta(omittable: true)
    attribute :designation_date, Types::Date
  end
end
