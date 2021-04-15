# frozen_string_literal: true

module AcaEntities
  module Families
    class Family < Dry::Struct

      attribute :family_members,                    Types::Array.of(AcaEntities::Families::FamilyMember).meta(omittable: false)
      attribute :households,                        Types::Array.of(AcaEntities::Households::Household).meta(omittable: false)

      attribute :hbx_id,                            Types::String.optional.meta(omittable: false)
      attribute :foreign_keys,                      Types::Array.of(AcaEntities::Identifiers::Id).optional.meta(omittable: true)
      attribute :renewal_consent_through_year,      Types::Integer.optional.meta(omittable: true)
      # TODO: Fix this, Move to right namespace as per DAN
      # attribute :application_type,                  Types::String.meta(omittable: false)
      attribute :min_verification_due_date,         Types::Date.optional.meta(omittable: true)
      attribute :vlp_documents_status,              Types::String.optional.meta(omittable: true)

      attribute :iap_application_references,
                Types::Array.of(AcaEntities::MagiMedicaid::ApplicationReference).optional.meta(omittable: true)
      attribute :documents,                         Types::Array.of(AcaEntities::Documents::Document).optional.meta(omittable: true)
      attribute :special_enrollment_periods,
                Types::Array.of(AcaEntities::EnrollmentPeriods::SpecialEnrollmentPeriod).optional.meta(omittable: true)
      attribute :broker_accounts,                   Types::Array.of(AcaEntities::Brokers::BrokerAccount).optional.meta(omittable: true)
      attribute :general_agency_accounts,
                Types::Array.of(AcaEntities::GeneralAgencies::GeneralAgencyAccount).optional.meta(omittable: true)
      attribute :irs_groups,                        Types::Array.of(AcaEntities::Groups::IrsGroup).optional.meta(omittable: true)
      attribute :payment_transactions,
                Types::Array.of(AcaEntities::Financial::PaymentTransactions::PaymentTransaction).optional.meta(omittable: true)
      attribute :updated_by,                        AcaEntities::People::PersonReference.optional.meta(omittable: true)
      attribute :timestamp,                         AcaEntities::TimeStamp.optional.meta(omittable: true)
    end
  end
end




