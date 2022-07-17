# frozen_string_literal: true

module AcaEntities
  module Families
    # The engagement and activities associated with a group of related {AcaEntities::People::Person}s.
    # Each Family must have one (only) {AcaEntities::Families::FamilyMember} as Primary Family Member
    # A Person has the Primary Family Member role for one Family only
    # A person may belong to may belong to more than one Family as long as they are the Primary Family
    # member on one family only
    class Family < Dry::Struct
      # @!attribute [r] hbx_id
      # HBX-assigned unique identifier for this family
      # @return [String]
      attribute :hbx_id, Types::String.optional.meta(omittable: false)

      # @!attribute [r] foreign_keys
      # All current and psst members of this family
      # @return [Array<AcaEntities::Identifiers::Id>]
      attribute :foreign_keys, Types::Array.of(AcaEntities::Identifiers::Id).optional.meta(omittable: true)

      # @!attribute [r] family_members
      # All current and psst members of this family
      # @return [Array<FamilyMember>]
      attribute :family_members, Types::Array.of(AcaEntities::Families::FamilyMember).meta(omittable: false)

      # @!attribute [r] households
      # Physical households over time with family_member composition
      # @return [Array<Household>]
      attribute :households, Types::Array.of(AcaEntities::Households::Household).optional.meta(omittable: true)

      attribute :irs_groups, Types::Array.of(AcaEntities::Groups::IrsGroup).optional.meta(omittable: true)

      # TODO: Replace specific VLP eligibility reference with FamilyEligibility
      attribute :min_verification_due_date, Types::Date.optional.meta(omittable: true)

      # attribute :vlp_documents_status,              Types::String.optional.meta(omittable: true)

      # TODO: Domain model supports EA internal MagiMedicaid (IAP) applications only.  Extend to support other application types,
      # TODO: including: ME ACES, FFM ATP, Curam ATP
      attribute :magi_medicaid_applications,
                Types::Array.of(AcaEntities::MagiMedicaid::Application).optional.meta(omittable: true)

      attribute :renewal_consent_through_year, Types::Integer.optional.meta(omittable: true)

      attribute :special_enrollment_periods,
                Types::Array.of(AcaEntities::EnrollmentPeriods::SpecialEnrollmentPeriod).optional.meta(omittable: true)
      attribute :general_agency_accounts,
                Types::Array.of(AcaEntities::GeneralAgencies::GeneralAgencyAccount).optional.meta(omittable: true)
      attribute :broker_accounts, Types::Array.of(AcaEntities::Brokers::BrokerAccount).optional.meta(omittable: true)
      attribute :payment_transactions,
                Types::Array
                  .of(AcaEntities::Financial::PaymentTransactions::PaymentTransaction)
                  .optional
                  .meta(omittable: true)
      attribute :documents, Types::Array.of(AcaEntities::Documents::Document).optional.meta(omittable: true)
      attribute :updated_by, AcaEntities::People::PersonReference.optional.meta(omittable: true)
      attribute :timestamp, AcaEntities::TimeStamp.optional.meta(omittable: true)
      attribute :documents_needed, Types::Bool.optional.meta(omittable: true)
      attribute :policies, Types::Array.of(AcaEntities::Policies::Policy).optional.meta(omittable: true)
    end
  end
end
