# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # An Applicant's access to Health Benefit Coverage
    class Benefit < Dry::Struct

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
      attribute :employee_cost,           Types::Float.optional.meta(omittable: true)
      attribute :employee_cost_frequency, Types::EmployeeCostFrequency.optional.meta(omittable: true)

      attribute :start_on,                Types::Date.optional.meta(omittable: true)
      attribute :end_on,                  Types::Date.optional.meta(omittable: true)
      attribute :submitted_at,            Types::DateTime.optional.meta(omittable: true)

      # attribute :workflow,                Iap::Workflow.meta(omittable: true)

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
    end
  end
end
