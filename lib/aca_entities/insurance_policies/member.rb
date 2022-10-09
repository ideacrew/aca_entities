# frozen_string_literal: true

module AcaEntities
  module Ledger
    # Schema and validation rules for {AcaEntities::Ledger::Member}
    class Member < Dry::Struct
      include Comparable

      # @!attribute [r] id
      # An system-assigned unambiguous reference to a member
      # @return [String]
      attribute? :id, Types::String.meta(omittable: true)

      # @!attribute [r] member_id
      # A Tenent-assigned unambiguous reference to a member.
      # @return [String]
      attribute :member_id, Types::String.meta(omittable: false)

      # @!attribute [r] insurer_assigned_id
      # An Insurance Provider-assigned unambiguous reference to a member
      # @return [String]
      attribute? :insurer_assigned_id, Types::String.meta(omittable: true)

      attribute :person_name, AcaEntities::People::PersonName.meta(omittable: false)

      attribute? :encrypted_ssn, Types::String.meta(omittable: true)

      # @!attribute [r] dob
      # Member's Date of Birth
      # @return [Date]
      attribute :dob, Types::Date.meta(omittable: true)

      # @!attribute [r] dob
      # Member's gender as male or female
      # @return [AcaEntities::Types::BinaryGenderKind]
      attribute :gender, AcaEntities::Types::BinaryGenderKind.meta(omittable: true)

      # @!attribute [r] relationship_code
      # Member's family relationship to the designated subscriber member in the group
      # @return [String]
      attribute? :relationship_code, Types::String.meta(omittable: true)

      # @!attribute [r] addresses
      # A list of Member's contact postal addresses
      # @return [Array<AcaEntities::Locations::SiteAddress>]
      attribute? :addresses, AcaEntities::Types::Array.of(AcaEntities::Locations::SiteAddress).meta(omittable: true)

      # @!attribute [r] emails
      # A list of Member's contact email addresses
      # @return [Array<AcaEntities::Contacts::EmailContact>]
      attribute? :emails, AcaEntities::Types::Array.of(AcaEntities::Contacts::EmailContact).meta(omittable: true)

      # @!attribute [r] phones
      # A list of Member's contact phone numbers
      # @return [Array<AcaEntities::Contacts::PhoneContact>]
      attribute? :phones, AcaEntities::Types::Array.of(AcaEntities::Contacts::PhoneContact).meta(omittable: true)

      # @!attribute [r] is_tobacco_user
      # Does this Member use tobacco products?
      # @return [Boolean]
      attribute? :is_tobacco_user, AcaEntities::Types::BoolOrNil.meta(omittable: true)

      # @!attribute [r] irs_group_id
      # An unambiguous reference to
      # @return [String]
      attribute? :irs_group_id, AcaEntities::Types::StringOrNil.meta(omittable: true)

      # @!attribute [r] tax_household_id
      # An unambiguous reference to the Tax Household
      # @return [String]
      attribute? :tax_household_id, AcaEntities::Types::StringOrNil.meta(omittable: true)
      attribute? :timestamps, AcaEntities::TimeStamp.meta(omittable: true)

      # Return if this member instance is the same as the other
      def <=>(other)
        member_comp =
          [hbx_id, ssn, dob, gender, tax_household_id, is_tobacco_user] <=> [
            other.hbx_id,
            other.ssn,
            other.dob,
            other.gender,
            other.tax_household_id,
            other.is_tobacco_user
          ]

        return person_name <=> other.person_name if member_comp == 0
      end
    end
  end
end
