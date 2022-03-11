# frozen_string_literal: true

module AcaEntities
  module Ledger
    # A set of financial assitance applicants grouped by APTC income parameters
    class TaxHousehold < Dry::Struct
      include Comparable

      attribute? :id, Types::Coercible::String.meta(omittable: true)
      attribute :assistance_year, Types::Coercible::Integer.meta(omittable: false)
      attribute :exchange_assigned_id, Types::Coercible::String.meta(omittable: false)
      attribute :aptc_amount, Types::Coercible::Decimal.meta(omittable: false)
      attribute? :csr, Types::Coercible::Integer.meta(omittable: true)
      attribute :start_on, Types::Date.meta(omittable: false)
      attribute? :end_on, Types::Date.meta(omittable: true)
      attribute? :timestamps, AcaEntities::TimeStamp.meta(omittable: true)

      def <=>(other)
        [assistance_year, exchange_assigned_id, aptc_amount, csr, start_on, end_on] <=> [
          other.assistance_year,
          other.exchange_assigned_id,
          other.aptc_amount,
          other.csr,
          other.start_on,
          other.end_on
        ]
      end
    end
  end
end
