# frozen_string_literal: true

module AcaEntities
  module Osse
    module ShopMarket
      class BenefitSponsorshipsEligibilities < Dry::Struct
        attribute? :id, Types::String.optional.meta(omittable: true)
        attribute :benefit_sponsorship, BenefitSponsorship.required.meta(omittable: false) # has_one
        attribute :eligibility, AcaEntities::Eligibilities::Eligibility.required.meta(omittable: false) # polymorphic
        attribute? :timestamps
      end
    end
  end
end
