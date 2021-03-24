# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # An Applicant's access to Health Benefit Coverage
    class Benefit < Dry::Struct

      # attribute :title
      # attribute :esi_covered(who_can_be_covered? self, self_and_spouse, family)
      # attribute :kind(is_enrolled is_eligible)
      # attribute :insurance_kind
      # attribute :is_employer_sponsored
      # attribute :is_esi_waiting_period
      # attribute :is_esi_mec_met
      # attribute :employee_cost
      # attribute :employee_cost_frequency
      # attribute :start_on
      # attribute :end_on
      # attribute :submitted_at
      # attribute :workflow
      # attribute :employer_name
      # attribute :employer_id

      # title
      attribute :name,                    Types::String.meta(omittable: false)
      # insurance_kind
      attribute :kind,                    Iap::Types::BenefitKind.meta(omittable: false)
      # kind
      attribute :status,                  Iap::Types::BenefitStatusKind.meta(omittable: false)

      attribute :is_employer_sponsored,   Types::Bool.meta(omittable: false)
      attribute :employer,                Iap::Employer.meta(omittable: true)

      attribute :esi_covered,             Types::String.meta(omittable: false)
      attribute :is_esi_waiting_period,   Types::Bool.meta(omittable: false)
      attribute :is_esi_mec_met,          Types::Bool.meta(omittable: false)

      attribute :employer_name,           Types::String.optional.meta(omittable: true)
      attribute :employer_id,             Types::String.optional.meta(omittable: true)

      # Money
      attribute :employee_cost,           Types::Decimal.meta(omittable: false)
      attribute :employee_cost_frequency, Types::String.meta(omittable: false)

      attribute :start_on,                Types::Date.meta(omittable: false)
      attribute :end_on,                  Types::Date.meta(omittable: false)
      attribute :submitted_at,            Types::DateTime.meta(omittable: false)

      attribute :workflow,                Iap::Workflow.meta(omittable: false)

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
