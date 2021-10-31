# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for ApplicantReference.
    class ApplicantReference < Dry::Struct

      attribute :first_name, Types::String.meta(omittable: false)
      attribute :last_name, Types::String.meta(omittable: false)
      attribute :dob, Types::Date.meta(omittable: false)
      # TODO: change this to :family_member_hbx_id once hbx_id is added to FamilyMember.
      attribute :person_hbx_id, Types::String.meta(omittable: false)
      attribute :encrypted_ssn, Types::String.optional.meta(omittable: true)
    end
  end
end
