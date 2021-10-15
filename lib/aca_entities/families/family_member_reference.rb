# frozen_string_literal: true

module AcaEntities
  module Families
    class FamilyMemberReference < Dry::Struct
      attribute :family_member_hbx_id,          Types::String.optional.meta(omittable: false)
      attribute :first_name,                    Types::String.optional.meta(omittable: true)
      attribute :last_name,                     Types::String.optional.meta(omittable: true)
      attribute :person_hbx_id,                 Types::String.optional.meta(omittable: true)
      attribute :is_primary_family_member,      Types::Bool.optional.meta(omittable: true)
      attribute :age,                           Types::Integer.optional.meta(omittable: true)
      attribute :ssn,                           Types::String.optional.meta(omittable: true)
      attribute :encrypted_ssn,                 Types::String.optional.meta(omittable: true)
      attribute :dob,                           Types::Date.optional.meta(omittable: true)
    end
  end
end