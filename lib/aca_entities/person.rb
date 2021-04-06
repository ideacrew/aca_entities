# frozen_string_literal: true

module AcaEntities
  class Person < ApplicantRole
    attribute :hbx_id,      Types::String.optional.meta(omittable: true)

    attribute :names,  Types::Array.of(AcaEntities::PersonName).meta(omittable: false)
    attribute :is_disabled, Types::Strict::Bool.meta(omittable: true)
    attribute :ethnicity, Types::Strict::Array.meta(omittable: true)
    attribute :race, Types::String.optional.meta(omittable: true)
    attribute :tribal_id, Types::String.optional.meta(omittable: true)

    attribute :language_code, Types::String.optional.meta(omittable: true)
    attribute :no_dc_address, Types::Strict::Bool.meta(omittable: true)
    attribute :is_homeless, Types::Strict::Bool.meta(omittable: true)
    attribute :is_temporarily_out_of_state, Types::Strict::Bool.meta(omittable: true)

    attribute :no_ssn, Types::String.optional.meta(omittable: true)
    attribute :same_with_primary, Types::Strict::Bool

    attribute :emails, Types::Array.of(Email)
    attribute :phones, Types::Array.of(Phone)
  end
end
