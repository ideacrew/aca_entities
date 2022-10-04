# frozen_string_literal: true

module AcaEntities
  module Osse
    module ShopMarket
      class BenefitSponsorshipsOsseProductGrant < Eligibilities
        attribute? :id, Types::String.optional.meta(omittable: true)
        attribute :benefit_sponsorship_instance # Subject
        attribute :is_satisfied, Types::Bool.meta(omittable: false)
        attribute? :timestamps
      end
    end
  end
end
