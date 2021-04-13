# frozen_string_literal: true

module AcaEntities
  module Enrollments
    class HbxEnrollment < Dry::Struct

      attribute :hbx_id,                                          Types::String.optional.meta(omittable: false)
      attribute :effective_on,                                    Types::Date.meta(omittable: false)
      attribute :aasm_state,                                      Types::String.meta(omittable: false)
      attribute :is_active,                                       Types::Bool.optional.meta(omittable: false)
      attribute :market_place_kind,                               Types::String.meta(omittable: false)
      attribute :enrollment_period_kind,                          Types::String.meta(omittable: false)
      attribute :product_kind,                                    Types::String.meta(omittable: false)
      attribute :terminated_on,                                   Types::Date.optional.meta(omittable: false)
      attribute :terminate_reason,                                Types::String.optional.meta(omittable: false)
      attribute :termination_submitted_on,                        Types::Date.optional.meta(omittable: false)
      attribute :waiver_reason,                                   Types::String.optional.meta(omittable: false)
      attribute :review_status,                                   Types::String.optional.meta(omittable: false)
      attribute :external_enrollment,                             Types::Strict::Bool.optional.meta(omittable: false)
      attribute :predecessor_enrollment,                          AcaEntities::Enrollments::HbxEnrollmentReference.optional.meta(omittable: false)
      attribute :product,                                         AcaEntities::Products::ProductReference.meta(omittable: false)
      attribute :issuer_profile,                                  AcaEntities::Organizations::IssuerProfileReference.meta(omittable: false)
      attribute :coverage_household,                              AcaEntities::Households::CoverageHouseholdReference.optional.meta(omittable: false)
      attribute :family,                                          AcaEntities::Families::FamilyReference.optional.meta(omittable: false)
      attribute :household,                                       AcaEntities::Households::HouseholdReference.optional.meta(omittable: false)
      attribute :special_enrollment_period,
                AcaEntities::EnrollmentPeriod::SpecialEnrollmentPeriodReference.optional.meta(omittable: false)
      attribute :broker_agency,                                   AcaEntities::Brokers::BrokerAgencyReference.optional.meta(omittable: false)
      # ivl attributes
      attribute :elected_amount,                                  AcaEntities::Curreny.meta(omittable: false)
      attribute :elected_premium_credit,                          AcaEntities::Curreny.meta(omittable: false)
      attribute :applied_premium_credit,                          AcaEntities::Curreny.meta(omittable: false)
      attribute :applied_aptc_amount,                             AcaEntities::Curreny.meta(omittable: false)
      attribute :elected_aptc_pct,                                Types::Float.meta(omittable: false)
      attribute :is_any_enrollment_member_outstanding,            Types::Bool.optional.meta(omittable: false)
      attribute :special_verification_period,                     Types::Date.optional.meta(omittable: false)
      attribute :enrollment_signature,                            Types::String.optional.meta(omittable: false)
      attribute :consumer_role,                                   AcaEntities::People::ConsumerRoleReference.optional.meta(omittable: false)
      attribute :resident_role,                                   AcaEntities::People::ResidentRoleReference.optional.meta(omittable: false)
      attribute :benefit_package,
                AcaEntities::BenefitCatalogs::BenefitPackageReference.optional.meta(omittable: false)
      attribute :benefit_coverage_period,
                AcaEntities::BenefitCatalogs::BenefitCoveragePeriodReference.optional.meta(omittable: false)
      # shop attributes
      attribute :employee_role,                                   AcaEntities::People::EmployeeRole.optional.meta(omittable: false)
      attribute :benefit_group_assignment,                        AcaEntities::References::BenefitGroupAssignment.optional.meta(omittable: false)
      attribute :benefit_sponsorship,                             AcaEntities::References::BenefitSponsorship.optional.meta(omittable: false)
      attribute :sponsored_benefit_package,                       AcaEntities::References::SponsoredBenefitPackage.optional.meta(omittable: false)
      attribute :sponsored_benefit,                               AcaEntities::References::SponsoredBenefit.optional.meta(omittable: false)
      attribute :rating_area,                                     AcaEntities::References::RatingArea.optional.meta(omittable: false)
      attribute :hbx_enrollment_members,                          Types::Array.of(Entities::Enrollments::HbxEnrollmentMembers).meta(omittable: false)
      attribute :updated_by,                                      AcaEntities::People::PersonReference.optional.meta(omittable: false)
      attribute :timestamp,                                       AcaEntities::TimeStamp.optional.meta(omittable: true)
    end
  end
end
