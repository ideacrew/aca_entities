# frozen_string_literal: true

module AcaEntities
  module Families
    class FamilyMemberReference < Dry::Struct
      attribute :family_member_hbx_id,          Types::String.optional.meta(omittable: false)
      attribute :first_name,                    Types::String.optional.meta(omittable: false)
      attribute :last_name,                     Types::String.optional.meta(omittable: false)
      attribute :person_hbx_id,                 Types::String.optional.meta(omittable: false)
      attribute :is_primary_family_member,      Types::Bool.optional.meta(omittable: false)
    end
  end
end