# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # An Applicant's access to Health Benefit Coverage
    class Benefit < Dry::Struct
      include AcaEntities::AppHelper

      # title
      attribute :name,                    Types::String.optional.meta(omittable: true)
      # insurance_kind
      attribute :kind,                    Types::BenefitKind.optional.meta(omittable: true)
      # kind
      attribute :status,                  Types::BenefitStatusKind.optional.meta(omittable: true)

      attribute :is_employer_sponsored,   Types::Bool.optional.meta(omittable: true)
      attribute :employer,                Employer.optional.meta(omittable: true)

      attribute :esi_covered,             Types::EsiCoveredKind.optional.meta(omittable: true)
      attribute :is_esi_waiting_period,   Types::Bool.optional.meta(omittable: true)
      attribute :is_esi_mec_met,          Types::Bool.optional.meta(omittable: true)

      # Money
      attribute :employee_cost,           Types::Money.optional.meta(omittable: true)
      attribute :employee_cost_frequency, Types::EmployeeCostFrequency.optional.meta(omittable: true)

      attribute :start_on,                Types::Date.optional.meta(omittable: true)
      attribute :end_on,                  Types::Date.optional.meta(omittable: true)
      attribute :submitted_at,            Types::DateTime.optional.meta(omittable: true)

      attribute :hra_kind,                Types::HraKind.optional.meta(omittable: true)

      # attribute :workflow,                Iap::Workflow.meta(omittable: true)

      # Does this employer offer a health plan that meets the minimum value standard and is considered affordable for the employee and family?
      # "To determine if the offer of coverage is affordable, use [hyperlink] CoverME.gov's Employer Insurance Tool" Y/N
      attribute :health_plan_meets_mvs_and_affordable, Types::Bool.optional.meta(omittable: true)

      # rubocop:disable Naming/PredicateName
      def is_eligible?
        status == 'is_eligible'
      end

      def is_enrolled?
        status == 'is_enrolled'
      end
      # rubocop:enable Naming/PredicateName

      def cobra_covered?
        kind == 'cobra'
      end

      # rubocop:disable Metrics/CyclomaticComplexity
      def annual_employee_cost
        return BigDecimal('0') if check_if_blank?(employee_cost_frequency) || check_if_blank?(employee_cost)

        case employee_cost_frequency
        when 'Weekly' then (employee_cost * 52)
        when 'Monthly' then (employee_cost * 12)
        when 'Annually' then employee_cost
        when 'BiWeekly' then (employee_cost * 26)
        when 'SemiMonthly' then (employee_cost * 24)
        when 'Quarterly' then (employee_cost * 4)
        when 'Hourly' then (employee_cost * 8 * 5 * 52)
        when 'Daily' then (employee_cost * 5 * 52)
        when 'SemiAnnually' then (employee_cost * 2)
        when '13xPerYear' then (employee_cost * 13)
        when '11xPerYear' then (employee_cost * 11)
        when '10xPerYear' then (employee_cost * 10)
        else BigDecimal('0')
        end
      end
      # rubocop:enable Metrics/CyclomaticComplexity

      def monthly_employee_cost
        annual_employee_cost / 12
      end
    end
  end
end
