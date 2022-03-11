# frozen_string_literal: true

module AcaEntities
  module Ledger
    # All insurance policies for an individual customer
    class InsuranceCoverage < Dry::Struct
      include Comparable

      attribute? :id, Types::Coercible::String.meta(omittable: true)
      attribute :hbx_id, Types::Coercible::String.meta(omittable: false)
      attribute? :tax_households, Types::Array.of(AcaEntities::Ledger::TaxHousehold).meta(omittable: true)
      attribute :policies, Types::Array.of(AcaEntities::Ledger::Policy).meta(omittable: false)
      attribute :is_active, Types::Bool.meta(omittable: false)
      attribute? :timestamps, AcaEntities::TimeStamp.meta(omittable: true)

      def <=>(other)
        [is_active] <=> [other.is_active]
      end
    end
  end
end
