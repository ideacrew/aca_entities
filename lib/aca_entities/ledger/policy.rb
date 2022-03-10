# frozen_string_literal: true

module AcaEntities
  module Ledger
    # A contract for insurance coverage
    class Policy < Dry::Struct
      include Comparable

      attribute? :id, Types::Coercible::String.meta(omittable: true)
      attribute :insurer, AcaEntities::Ledger::Insurer.meta(omittable: false)
      attribute :product, AcaEntities::Ledger::Product.meta(omittable: false)
      attribute :marketplace_segments, Types::Array.of(AcaEntities::Ledger::MarketplaceSegment).meta(omittable: false)
      attribute :exchange_assigned_id, Types::Coercible::String.meta(omittable: false)
      attribute? :insurer_assigned_id, Types::Coercible::String.meta(omittable: true)
      attribute :subscriber_hbx_id, Types::Coercible::String.meta(omittable: false)
      attribute? :service_area_id, Types::Coercible::String.meta(omittable: true)
      attribute :rating_area_id, Types::Coercible::String.meta(omittable: false)
      attribute :start_on, Types::Date.meta(omittable: false)
      attribute? :end_on, Types::Date.meta(omittable: true)
      attribute? :timestamps, AcaEntities::TimeStamp.meta(omittable: true)

      def <=>(other)
        comparison =
          [subscriber_hbx_id, start_on, end_on, service_area_id, rating_area_id] <=> [
            other.subscriber_hbx_id,
            other.start_on,
            other.end_on,
            other.service_area_id,
            other.rating_area_id
          ]

        # require 'pry'
        # binding.pry
        product_comparison = product <=> other.product
        insurer_comparison = insurer <=> other.insurer

        # marketplace_segments_comparison = marketplace_segments.any? { |segment| (segment <=> other.segment) }

        return product <=> other.product if (comparison == 0) && (product_comparison != 0)
        return insurer <=> other.insurer if (comparison == 0) && (insurer_comparison != 0)

        # return 1 if marketplace_segments.any? { |segment| (segment <=> other.segment) != 0 }
        comparison
      end
    end
  end
end
