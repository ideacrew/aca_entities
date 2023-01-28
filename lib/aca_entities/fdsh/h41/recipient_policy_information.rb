# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      # Entity for h41 RecipientPolicyInformation
      class RecipientPolicyInformation
        attribute :JanPremiumInformation,  AcaEntities::Fdsh::H41::MonthlyPremiumInformation.meta(omittable: false)
        attribute :FebPremiumInformation,  AcaEntities::Fdsh::H41::MonthlyPremiumInformation.meta(omittable: false)
        attribute :MarPremiumInformation,  AcaEntities::Fdsh::H41::MonthlyPremiumInformation.meta(omittable: false)
        attribute :AprPremiumInformation,  AcaEntities::Fdsh::H41::MonthlyPremiumInformation.meta(omittable: false)
        attribute :MayPremiumInformation,  AcaEntities::Fdsh::H41::MonthlyPremiumInformation.meta(omittable: false)
        attribute :JunPremiumInformation,  AcaEntities::Fdsh::H41::MonthlyPremiumInformation.meta(omittable: false)
        attribute :JulPremiumInformation,  AcaEntities::Fdsh::H41::MonthlyPremiumInformation.meta(omittable: false)
        attribute :AugPremiumInformation,  AcaEntities::Fdsh::H41::MonthlyPremiumInformation.meta(omittable: false)
        attribute :SepPremiumInformation,  AcaEntities::Fdsh::H41::MonthlyPremiumInformation.meta(omittable: false)
        attribute :OctPremiumInformation,  AcaEntities::Fdsh::H41::MonthlyPremiumInformation.meta(omittable: false)
        attribute :NovPremiumInformation,  AcaEntities::Fdsh::H41::MonthlyPremiumInformation.meta(omittable: false)
        attribute :DecPremiumInformation,  AcaEntities::Fdsh::H41::MonthlyPremiumInformation.meta(omittable: false)
        attribute :AnnualPolicyTotalAmounts,  AcaEntities::Fdsh::H41::AnnaulPremiumTotalAmounts.meta(omittable: false)
      end
    end
  end
end
