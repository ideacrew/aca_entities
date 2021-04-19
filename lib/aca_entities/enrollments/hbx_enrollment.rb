# frozen_string_literal: true

module AcaEntities
  module Enrollments
    class HbxEnrollment < Dry::Struct

      attribute :hbx_id,                                          Types::String.optional.meta(omittable: false)
      attribute :effective_on,                                    Types::Date.meta(omittable: false)
      attribute :aasm_state,                                      Types::String.meta(omittable: false)
      attribute :is_active,                                       Types::Bool.optional.meta(omittable: true)
      attribute :market_place_kind,                               AcaEntities::Types::EnrollmentMarketPlaceKind.meta(omittable: false)
      attribute :enrollment_period_kind,                          AcaEntities::Types::EnrollmentKind.meta(omittable: false)
      attribute :product_kind,                                    AcaEntities::Types::ProductKind.meta(omittable: false)
      attribute :product_reference,                               AcaEntities::Products::ProductReference.meta(omittable: false)
      attribute :issuer_profile_reference,                        AcaEntities::Organizations::IssuerProfileReference.meta(omittable: false)

      attribute :coverage_household_reference,                    AcaEntities::Households::CoverageHouseholdReference.optional.meta(omittable: true)
      attribute :family_hbx_id,                                   Types::String.optional.meta(omittable: false)
      attribute :terminated_on,                                   Types::Date.optional.meta(omittable: true)
      attribute :terminate_reason,                                Types::String.optional.meta(omittable: true)
      attribute :termination_submitted_on,                        Types::Date.optional.meta(omittable: true)
      attribute :waiver_reason,                                   Types::String.optional.meta(omittable: true)
      attribute :review_status,                                   Types::String.optional.meta(omittable: true)
      attribute :external_enrollment,                             Types::Strict::Bool.optional.meta(omittable: true)
      attribute :predecessor_enrollment,                          AcaEntities::Enrollments::HbxEnrollmentReference.optional.meta(omittable: true)
      attribute :special_enrollment_period_reference,
                AcaEntities::EnrollmentPeriods::SpecialEnrollmentPeriodReference.optional.meta(omittable: true)
      attribute :broker_role_reference,
                AcaEntities::Brokers::BrokerRoleReference.optional.meta(omittable: true)
      attribute :broker_agency_reference,
                AcaEntities::Organizations::BrokerAgencyProfileReference.optional.meta(omittable: true)

      # ivl attributes
      attribute :elected_amount,                                  AcaEntities::Curreny.meta(omittable: true)
      attribute :elected_premium_credit,                          AcaEntities::Curreny.meta(omittable: true)
      attribute :applied_premium_credit,                          AcaEntities::Curreny.meta(omittable: true)
      attribute :applied_aptc_amount,                             AcaEntities::Curreny.meta(omittable: true)
      attribute :elected_aptc_pct,                                Types::Float.meta(omittable: true)
      attribute :is_any_enrollment_member_outstanding,            Types::Bool.optional.meta(omittable: true)
      attribute :special_verification_period,                     Types::Date.optional.meta(omittable: true)
      attribute :enrollment_signature,                            Types::String.optional.meta(omittable: true)
      attribute :consumer_role_reference,                         AcaEntities::People::ConsumerRoleReference.optional.meta(omittable: true)
      attribute :resident_role_reference,                         AcaEntities::People::ResidentRoleReference.optional.meta(omittable: true)
      attribute :benefit_package_reference,
                AcaEntities::BenefitCatalogs::BenefitPackageReference.optional.meta(omittable: true)
      attribute :benefit_coverage_period_reference,
                AcaEntities::BenefitCatalogs::BenefitCoveragePeriodReference.optional.meta(omittable: true)

      # shop attributes
      # attribute :employee_role,                                   AcaEntities::People::EmployeeRole.optional.meta(omittable: false)
      # attribute :benefit_group_assignment,                        AcaEntities::References::BenefitGroupAssignment.optional.meta(omittable: false)
      # attribute :benefit_sponsorship,                             AcaEntities::References::BenefitSponsorship.optional.meta(omittable: false)
      # attribute :sponsored_benefit_package,                       AcaEntities::References::SponsoredBenefitPackage.optional.meta(omittable: false)
      # attribute :sponsored_benefit,                               AcaEntities::References::SponsoredBenefit.optional.meta(omittable: false)
      # attribute :rating_area,                                     AcaEntities::References::RatingArea.optional.meta(omittable: false)

      attribute :hbx_enrollment_members,
                Types::Array.of(AcaEntities::Enrollments::HbxEnrollmentMember).meta(omittable: false)
      attribute :updated_by,                                      AcaEntities::People::PersonReference.optional.meta(omittable: true)
      attribute :timestamp,                                       AcaEntities::TimeStamp.optional.meta(omittable: true)
    end
  end
end
