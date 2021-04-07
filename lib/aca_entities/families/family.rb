# frozen_string_literal: true

module AcaEntities
  module Families
    class Family < Dry::Struct

      # This map to family#hbx_assigned_id in enroll
      attribute :hbx_id,                            Types::String.meta(omittable: false)

      #move to medicad
      attribute :e_case_id,                         Types::String.optional.meta(omittable: true)
      attribute :e_status_code,                     Types::String.optional.meta(omittable: true)
      attribute :renewal_consent_through_year,      Types::Integer.optional.meta(omittable: true)

      #TODO Add application types #move to eligibity
      attribute :application_type,                  Types::String.meta(omittable: false)

      attribute :is_active,                         Types::Bool.meta(omittable: false)
      attribute :status,                            Types::String.optional.meta(omittable: true)
      attribute :min_verification_due_date,         Types::Date.optional.meta(omittable: true)
      attribute :vlp_documents_status,              Types::String.optional.meta(omittable: true)
      attribute :updated_by,                        AcaEntities::References::Person.optional.meta(omittable: true)
      attribute :applications,                      Types::Strict::Array.of(AcaEntities::MagiMedicaid::ApplicationReference).optional.meta(omittable: true)
      attribute :documents,                         Types::Strict::Array.of(AcaEntities::Documents::Document).optional.meta(omittable: true)
      attribute :family_members,                    Types::Strict::Array.of(AcaEntities::Families::FamilyMember).meta(omittable: false)
      attribute :special_enrollment_periods,        Types::Strict::Array.of(AcaEntities::EnrollmentPeriods::SpecialEnrollmentPeriod).optional.meta(omittable: true)
      attribute :households,                        Types::Strict::Array.of(AcaEntities::Households::Household).meta(omittable: false)
      attribute :broker_accounts,                   Types::Strict::Array.of(AcaEntities::Brokers::BrokerAccount).optional.meta(omittable: true)
      attribute :general_agency_accounts,           Types::Strict::Array.of(AcaEntities::GeneralAgencies::GeneralAgencyAccount).optional.meta(omittable: true)
      attribute :irs_groups,                        Types::Strict::Array.of(AcaEntities::Groups::IrsGroup).optional.meta(omittable: true)
      attribute :payment_transactions,              Types::Strict::Array.of(AcaEntities::Financial::PaymentTransactions::PaymentTransaction).optional.meta(omittable: true)
      attribute :timestamp,                         AcaEntities::TimeStamp.optional.meta(omittable: true)
    end
  end
end




