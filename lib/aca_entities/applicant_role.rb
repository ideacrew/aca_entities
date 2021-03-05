# frozen_string_literal: true

module AcaEntities
  class ApplicantRole < Dry::Struct
    attribute :name_pfx,                        Types::String.optional.meta(omittable: true)
    attribute :first_name,                      Types::String
    attribute :middle_name,                     Types::String.optional.meta(omittable: true)
    attribute :last_name,                       Types::String
    attribute :name_sfx,                        Types::String.optional.meta(omittable: true)
    attribute :ssn,                             Types::String.optional.meta(omittable: true)
    attribute :gender,                          Types::String
    attribute :dob,                             Types::Date
    attribute :is_incarcerated,                 Types::Bool
    attribute :is_veteran_or_active_military,   Types::Bool.optional.meta(omittable: true)
    attribute :citizen_status,                  Types::String.meta(omittable: false)
    attribute :is_resident_post_092296,         Types::Bool.optional.meta(omittable: true)
    attribute :indian_tribe_member,             Types::Bool
    attribute :is_physically_disabled,          Types::Bool.optional.meta(omittable: true)
    attribute :is_self_attested_long_term_care, Types::Bool.optional.meta(omittable: true)
    attribute :addresses,                       Types::Array.of(Address).optional.meta(omittable: true)
  end
end
