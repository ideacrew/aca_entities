# frozen_string_literal: true

module AcaEntities
  # Entity for EmployerSponsoredInsuranceInformation.
  class EmployerSponsoredInsuranceInformation < Dry::Struct
    attribute :employer_ein,            Types::String.optional.meta(omittable: true)
    attribute :employer_name,           Types::String.optional.meta(omittable: true)
    attribute :is_a_cobra_coverage,     Types::Bool.optional.meta(omittable: true)
    attribute :employee_status_code,    Types::String.optional.meta(omittable: true)
    attribute :changes_esi_status,      Types::Bool.optional.meta(omittable: true)
    attribute :retiree_plan_coverage,   Types::Bool.optional.meta(omittable: true)

    # Lowest Cost Self Only Plan.
    attribute :lcsop_coverage_code,     Types::String.optional.meta(omittable: true)
    # Date the employer will stop offering health coverage.
    attribute :lcsop_end_date,          Types::Date.optional.meta(omittable: true)

    attribute :lcsop_cost_code,         Types::String.optional.meta(omittable: true)
    attribute :lcsop_cost_change_date,  Types::Date.optional.meta(omittable: true)
    attribute :new_lcsop_premium,       Types::Float.optional.meta(omittable: true)
    attribute :is_employer_active,      Types::Bool.optional.meta(omittable: true)

    # This is the date the LCSOP will no longer be offered through the employer.
    attribute :date_employer_drops_lcsop,  Types::Date.optional.meta(omittable: true)

    # Applicant does not know the cost to enroll in LCSOP.
    attribute :employee_do_not_know_lcsop_cost, Types::Bool.optional.meta(omittable: true)

    # Applicant does not know if he/she is elgible for coverage through a job.
    attribute :employee_do_not_know_offered_coverage, Types::Bool.optional.meta(omittable: true)
    attribute :employee_will_drop_coverage_code, Types::String.optional.meta(omittable: true)

    attribute :employee_plans_to_enroll_in_esi,  Types::Bool.optional.meta(omittable: true)
    attribute :esi_coverage_start_date,  Types::Date.optional.meta(omittable: true)
    attribute :esi_coverage_end_date,  Types::Date.optional.meta(omittable: true)
    attribute :is_offered, Types::Bool.optional.meta(omittable: true)
    attribute :is_enrolled, Types::Bool.optional.meta(omittable: true)
    attribute :eligible_to_enroll_date, Types::Date.optional.meta(omittable: true)
  end
end
