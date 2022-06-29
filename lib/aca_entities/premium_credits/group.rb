# frozen_string_literal: true

module AcaEntities
  module PremiumCredits
    # Cv3 Entity for GroupPremiumCredit
    # AcaEntities::PremiumCredits::Contracts::GroupContract
    class Group < Dry::Struct
      # @!attribute [r] members
      # All members of the group
      # @return [Array<AcaEntities::PremiumCredits::Member>]
      attribute :members, Types::Array.of(AcaEntities::PremiumCredits::Member).meta(omittable: false)

      # @!attribute [r] id
      # Unique key for this entity.
      # @return [String]
      attribute :id, Types::String.optional.meta(omittable: true)

      # @!attribute [r] kind
      # The type of premium credit
      # Example: 'aptc_csr', 'employer_contribution'
      # @return [AcaEntities::PremiumCredits::Types::GroupKind]
      attribute :kind, ::AcaEntities::PremiumCredits::Types::GroupKind.meta(omittable: false)

      # @!attribute [r] authority_determination_reference
      # The Authority Determination of the Group Premium Credit
      # @return [AcaEntities::PremiumCredits::ObjectReference]
      attribute :authority_determination_reference, ::AcaEntities::PremiumCredits::ObjectReference.optional.meta(omittable: true)

      # @!attribute [r] premium_credit_monthly_cap
      # Value of the Group Premium Credit.
      # Example: '300.18'
      # @return [String]
      attribute :premium_credit_monthly_cap, Types::String.optional.meta(omittable: true)

      # @!attribute [r] sub_group_reference
      # The Sub Group Mapper of the Group Premium Credit
      # @return [AcaEntities::PremiumCredits::ObjectReference]
      attribute :sub_group_reference, ::AcaEntities::PremiumCredits::ObjectReference.optional.meta(omittable: true)

      # @!attribute [r] expected_contribution_percentage
      # The Expected Contribution Percentage for the Group
      # Example: 0.0318
      # @return [AcaEntities::Types::Money]
      attribute :expected_contribution_percentage, ::AcaEntities::Types::Money.optional.meta(omittable: true)

      # @!attribute [r] start_on
      # Start On date of the Member Premium Credit
      # @return [Date]
      attribute :start_on, Types::Date.meta(omittable: false)

      # @!attribute [r] end_on
      # End On date of the Member Premium Credit
      # @return [Date]
      attribute :end_on, Types::Date.optional.meta(omittable: true)

      # @!attribute [r] timestamps
      # Additional timestamps of the Member Premium Credit
      # @return [AcaEntities::TimeStamp]
      attribute :timestamps, ::AcaEntities::TimeStamp.optional.meta(omittable: true)
    end
  end
end
