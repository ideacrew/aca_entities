# frozen_string_literal: true

module AcaEntities
  module Ledger
    # A group member enrolled in coverage, their monthly premium amount and coverage
    #   period
    class EnrolledMember < Dry::Struct
      include Comparable

      attribute? :id, Types::Coercible::String.meta(omittable: true)
      attribute? :coverage_period, Types::Coercible::String.meta(omittable: true)
      attribute :member, AcaEntities::Ledger::Member.meta(omittable: false)
      attribute :premium, AcaEntities::Ledger::Premium.meta(omittable: false)
      attribute :start_on, Types::Date.meta(omittable: false)
      attribute? :end_on, Types::Date.meta(omittable: true)
      attribute? :timestamps, AcaEntities::TimeStamp.meta(omittable: true)

      def <=>(other)
        comparison = [start_on, end_on] <=> [other.start_on, other.end_on]
        member_comparison = member <=> other.member
        premium_comparison = premium <=> other.premium

        return member <=> other.member if (comparison == 0) && (member_comparison != 0)
        return premium <=> other.premium if (comparison == 0) && (premium_comparison != 0)
        comparison
      end
    end
  end
end
