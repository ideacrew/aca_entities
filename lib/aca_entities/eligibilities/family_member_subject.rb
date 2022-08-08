# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # A family member subject references family members for eligibility
    class FamilyMemberSubject < Dry::Struct

      # @!attribute [r] first_name
      # Family member first name
      # @return [String]
      attribute :first_name, Types::String.meta(omittable: false)

      # @!attribute [r] last_name
      # Family member last name
      # @return [String]
      attribute :last_name, Types::String.meta(omittable: false)

      # @!attribute [r] dob
      # Family member date of birth
      # @return [Date]
      attribute :dob, Types::Date.meta(omittable: false)

      # @!attribute [r] encrypted_ssn
      # Family member ssn
      # @return [String]
      attribute? :encrypted_ssn, Types::String.meta(omittable: true)

      # @!attribute [r] hbx_id
      # Family member person record hbx assigned id
      # @return [String]
      attribute :hbx_id, Types::String.meta(omittable: false)

      # @!attribute [r] hbx_id
      # Family member person record bson id
      # @return [String]
      attribute :person_id, Types::String.meta(omittable: false)

      # @!attribute [r] hbx_id
      # Family member primary applicant boolean flag
      # @return [Boolean]
      attribute :is_primary, Types::Bool.meta(omittable: false)
    end
  end
end
