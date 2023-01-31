# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H41
          # Happymapper implementation for the root object of an Request.
          class RecipientPolicyInformation
            include HappyMapper
            register_namespace 'airty20a', 'urn:us:gov:treasury:irs:ext:aca:air:ty20a'

            tag 'RecipientPolicyInformation'
            namespace 'airty20a'

            has_one :JanPremiumInformation, MonthlyPremiumInformation, tag: "JanPremiumInformation"
            has_one :FebPremiumInformation, MonthlyPremiumInformation, tag: "FebPremiumInformation"
            has_one :MarPremiumInformation, MonthlyPremiumInformation, tag: "MarPremiumInformation"
            has_one :AprPremiumInformation, MonthlyPremiumInformation, tag: "AprPremiumInformation"
            has_one :MayPremiumInformation, MonthlyPremiumInformation, tag: "MayPremiumInformation"
            has_one :JunPremiumInformation, MonthlyPremiumInformation, tag: 'JunPremiumInformation'
            has_one :JulPremiumInformation, MonthlyPremiumInformation, tag: 'JulPremiumInformation'
            has_one :AugPremiumInformation, MonthlyPremiumInformation, tag: 'AugPremiumInformation'
            has_one :SepPremiumInformation, MonthlyPremiumInformation, tag: 'SepPremiumInformation'
            has_one :OctPremiumInformation, MonthlyPremiumInformation, tag: 'OctPremiumInformation'
            has_one :NovPremiumInformation, MonthlyPremiumInformation, tag: 'NovPremiumInformation'
            has_one :DecPremiumInformation, MonthlyPremiumInformation, tag: 'DecPremiumInformation'
            has_one :AnnualPolicyTotalAmounts, AnnualPolicyTotalAmount, tag: 'AnnualPolicyTotalAmounts'

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.JanPremiumInformation = MonthlyPremiumInformation.domain_to_mapper(request.JanPremiumInformation)
              mapper.FebPremiumInformation = MonthlyPremiumInformation.domain_to_mapper(request.FebPremiumInformation)
              mapper.MarPremiumInformation = MonthlyPremiumInformation.domain_to_mapper(request.MarPremiumInformation)
              mapper.AprPremiumInformation = MonthlyPremiumInformation.domain_to_mapper(request.AprPremiumInformation)
              mapper.MayPremiumInformation = MonthlyPremiumInformation.domain_to_mapper(request.MayPremiumInformation)
              mapper.JunPremiumInformation = MonthlyPremiumInformation.domain_to_mapper(request.JunPremiumInformation)
              mapper.JulPremiumInformation = MonthlyPremiumInformation.domain_to_mapper(request.JulPremiumInformation)
              mapper.AugPremiumInformation = MonthlyPremiumInformation.domain_to_mapper(request.AugPremiumInformation)
              mapper.SepPremiumInformation = MonthlyPremiumInformation.domain_to_mapper(request.SepPremiumInformation)
              mapper.OctPremiumInformation = MonthlyPremiumInformation.domain_to_mapper(request.OctPremiumInformation)
              mapper.NovPremiumInformation = MonthlyPremiumInformation.domain_to_mapper(request.NovPremiumInformation)
              mapper.DecPremiumInformation = MonthlyPremiumInformation.domain_to_mapper(request.DecPremiumInformation)
              mapper.AnnualPolicyTotalAmounts = AnnualPolicyTotalAmount.domain_to_mapper(request.AnnualPolicyTotalAmounts)
              mapper
            end
          end
        end
      end
    end
  end
end
