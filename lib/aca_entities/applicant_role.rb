# frozen_string_literal: true

module AcaEntities
  class ApplicantRole < Dry::Struct

    attribute :first_name,                      Types::String
    attribute :middle_name,                     Types::String.optional.meta(omittable: true)
    attribute :last_name,                       Types::String
    attribute :name_sfx,                        Types::String.optional.meta(omittable: true)
    attribute :name_pfx,                        Types::String.optional.meta(omittable: true)
    attribute :dob,                             Types::Date
    attribute :gender,                          Types::String
    attribute :is_veteran_or_active_military,   Types::Bool.optional.meta(omittable: true)
    attribute :age_of_applicant,                Types::Integer.optional.meta(omittable: true)
    attribute :ssn,                             Types::String.optional.meta(omittable: true)
    attribute :citizen_status,                  Types::String.meta(omittable: false)
    attribute :is_resident_post_092296,         Types::Bool.optional.meta(omittable: true)
    attribute :is_student,                      Types::Bool.optional.meta(omittable: true)

    attribute :is_incarcerated,                 Types::Bool
    attribute :indian_tribe_member,             Types::Bool
    attribute :is_physically_disabled,          Types::Bool.optional.meta(omittable: true)
    attribute :is_self_attested_long_term_care, Types::Bool.optional.meta(omittable: true)
    attribute :addresses,                       Types::Array.of(Address).optional.meta(omittable: true)
  end
end
