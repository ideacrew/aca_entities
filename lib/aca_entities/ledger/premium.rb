# frozen_string_literal: true

module AcaEntities
  module Ledger
    # Plan premium amount for a given age
    class Premium < Dry::Struct
      include Comparable

      attribute? :id, Types::Coercible::String.meta(omittable: true)
      attribute? :product, AcaEntities::Ledger::Product.meta(omittable: true)
      attribute? :insured_age, Types::Integer.meta(omittable: true)
      attribute :amount, Types::Float.meta(omittable: false)
      attribute? :timestamps, AcaEntities::TimeStamp.meta(omittable: true)

      def <=>(other)
        [amount, insured_age] <=> [other.amount, other.insured_age]
      end
    end
  end
end
