# frozen_string_literal: true

module Iap

  # An Applicant's access to Health Benefit Coverage
  class Benefit < Dry::Struct

    attribute :name,                    Types::String.meta(omittable: false)
    attribute :kind,                    Iap::Types::BenefitKind.meta(omittable: false)
    attribute :status,                  Iap::Types::BenefitStatusKind.meta(omittable: false)

    attribute :is_employer_sponsored,   Types::Bool.meta(omittable: false)
    attribute :employer,                Iap::Employer.meta(omittable: true)

    attribute :esi_covered,             Types::String.meta(omittable: false)
    attribute :is_esi_waiting_period,   Types::Bool.meta(omittable: false)
    attribute :is_esi_mec_met,          Types::Bool.meta(omittable: false)

    # Money
    attribute :employee_cost,           Types::Decimal.meta(omittable: false)
    attribute :employee_cost_frequency, Types::String.meta(omittable: false)

    attribute :start_on,                Types::Date.meta(omittable: false)
    attribute :end_on,                  Types::Date.meta(omittable: false)
    attribute :submitted_at,            Types::DateTime.meta(omittable: false)

    attribute :workflow,                Iap::Workflow.meta(omittable: false)

    def is_eligible?
      status == 'is_eligible'
    end

    def is_enrolled?
      status == 'is_enrolled'
    end


  end
end
