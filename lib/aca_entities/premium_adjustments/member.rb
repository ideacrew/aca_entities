# frozen_string_literal: true

module AcaEntities
  module PremiumCredits
    # Cv3 Entity for MemberPremiumCredit
    # AcaEntities::PremiumCredits::Contracts::MemberContract
    class Member < Dry::Struct

      # @!attribute [r] id
      # Unique key for this entity.
      # @return [String]
      attribute :id, Types::String.optional.meta(omittable: true)

      # @!attribute [r] kind
      # The type of premium credit
      # Example: 'aptc_eligible', 'csr'
      # @return [AcaEntities::PremiumCredits::Types::MemberKind]
      attribute :kind, ::AcaEntities::PremiumCredits::Types::MemberKind.meta(omittable: false)

      # @!attribute [r] value
      # Value of the Member Premium Credit.
      # Example: true, '87'
      # @return [String]
      attribute :value, Types::String.optional.meta(omittable: true)

      # @!attribute [r] start_on
      # Start On date of the Member Premium Credit
      # @return [Date]
      attribute :start_on, Types::Date.meta(omittable: false)

      # @!attribute [r] end_on
      # End On date of the Member Premium Credit
      # @return [Date]
      attribute :end_on, Types::Date.optional.meta(omittable: true)

      # @!attribute [r] family_member_reference
      # Member Premium Credit maps to Family Member.
      # @return [AcaEntities::Families::FamilyMemberReference]
      attribute :family_member_reference, AcaEntities::Families::FamilyMemberReference.meta(omittable: false)

      # @!attribute [r] timestamps
      # Additional timestamps of the Member Premium Credit
      # @return [AcaEntities::TimeStamp]
      attribute :timestamps, ::AcaEntities::TimeStamp.optional.meta(omittable: true)
    end
  end
end
