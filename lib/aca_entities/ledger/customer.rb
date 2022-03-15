# frozen_string_literal: true

module AcaEntities
  module Ledger
    # Schema and validation rules for {AcaEntities::Ledger::Member}
    class Customer < Dry::Struct
      include Comparable

      attribute? :id, Types::Coercible::String.meta(omittable: true)
      attribute :hbx_id, Types::Coercible::String.meta(omittable: false)
      attribute :first_name, Types::Coercible::String.meta(omittable: false)
      attribute :last_name, Types::Coercible::String.meta(omittable: false)
      attribute :customer_role, Types::Coercible::String.meta(omittable: false)
      attribute :account, AcaEntities::Ledger::Account.meta(omittable: false)
      attribute :insurance_coverage, AcaEntities::Ledger::InsuranceCoverage.meta(omittable: false)
      attribute :is_active, Types::Bool.meta(omittable: false)
      attribute? :timestamps, AcaEntities::TimeStamp.meta(omittable: true)

      def <=>(other)
        comparison = [first_name, last_name, is_active] <=> [other.first_name, other.last_name, other.is_active]

        insurance_coverage_comparison = insurance_coverage <=> other.insurance_coverage

        # rubocop:disable Style/IfUnlessModifier
        if (comparison == 0) && (insurance_coverage_comparison != 0)
          return insurance_coverage_comparison <=> other.insurance_coverage_comparison
        end

        # rubocop:enable Style/IfUnlessModifier

        comparison
      end
    end
  end
end
