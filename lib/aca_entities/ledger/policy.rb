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

      # Define attribute differences that constitute equality (==) between two Policy class instances.
      # Note this comparison Will Not detect differences in child {AcaEntities::Ledger::EnrolledBenefit}
      # instances as policy_1 != policy_2.  Use {AcaEntities::Ledger::EnrolledBenefit} comparison
      # to detect differences at that level
      def <=>(other)
        comparison =
          [exchange_assigned_id, subscriber_hbx_id, start_on, end_on, service_area_id, rating_area_id] <=> [
            other.exchange_assigned_id,
            other.subscriber_hbx_id,
            other.start_on,
            other.end_on,
            other.service_area_id,
            other.rating_area_id
          ]

        product_comparison = product <=> other.product
        insurer_comparison = insurer <=> other.insurer

        return product <=> other.product if (comparison == 0) && (product_comparison != 0)
        return insurer <=> other.insurer if (comparison == 0) && (insurer_comparison != 0)
        comparison
      end
    end
  end
end
