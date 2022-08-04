# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    # Entity for Evidence
    class FamilyMemberSubject < Dry::Struct

      attribute :first_name, Types::String.meta(omittable: false)
      attribute :last_name, Types::String.meta(omittable: false)
      attribute :dob, Types::Date.meta(omittable: false)
      attribute? :encrypted_ssn, Types::String.meta(omittable: true)
      attribute :hbx_id, Types::String.meta(omittable: false)
      attribute :person_id, Types::String.meta(omittable: false)
      attribute :is_primary, Types::Bool.meta(omittable: false)
    end
  end
end
