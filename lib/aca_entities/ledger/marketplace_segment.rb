# frozen_string_literal: true

module AcaEntities
  module Ledger
    # A continuous time period under a policy where the Subscriber and
    #   {EnrolledMember}[Enrolled Members] are unchanged
    class MarketplaceSegment < Dry::Struct
      include Comparable

      attribute? :id, Types::Coercible::String.meta(omittable: true)
      attribute? :coverage_period, Types::Coercible::String.meta(omittable: true)
      attribute :segment, Types::Coercible::String.meta(omittable: true)
      attribute :total_premium_amount, Types::Coercible::Decimal.meta(omittable: true)
      attribute :total_premium_responsibility_amount, Types::Coercible::Decimal.meta(omittable: true)
      attribute :start_on, Types::Date.meta(omittable: true)
      attribute? :end_on, AcaEntities::Types::DateOrNil.meta(omittable: true)
      attribute :enrolled_members, Types::Array.of(AcaEntities::Ledger::EnrolledMember).meta(omittable: true)
      attribute? :subscriber_hbx_id, Types::Coercible::String.meta(omittable: true)
      attribute? :timestamps, AcaEntities::TimeStamp.meta(omittable: true)

      def <=>(other)
        comparison =
          [start_on, total_premium_amount, end_on] <=> [other.start_on, other.total_premium_amount, other.end_on]
        return enrolled_members <=> other.enrolled_members if comparison == 0
        comparison
      end
    end
  end
end
