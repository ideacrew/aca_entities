# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for H41 RecipientPolicyInformationContract
        class RecipientPolicyInformationContract < Dry::Validation::Contract
          params do
            required(:JanPremiumInformation).filled(AcaEntities::Fdsh::H41::Contracts::MonthlyPremiumInformationContract.params)
            required(:FebPremiumInformation).filled(AcaEntities::Fdsh::H41::Contracts::MonthlyPremiumInformationContract.params)
            required(:MarPremiumInformation).filled(AcaEntities::Fdsh::H41::Contracts::MonthlyPremiumInformationContract.params)
            required(:AprPremiumInformation).filled(AcaEntities::Fdsh::H41::Contracts::MonthlyPremiumInformationContract.params)
            required(:MayPremiumInformation).filled(AcaEntities::Fdsh::H41::Contracts::MonthlyPremiumInformationContract.params)
            required(:JunPremiumInformation).filled(AcaEntities::Fdsh::H41::Contracts::MonthlyPremiumInformationContract.params)
            required(:JulPremiumInformation).filled(AcaEntities::Fdsh::H41::Contracts::MonthlyPremiumInformationContract.params)
            required(:AugPremiumInformation).filled(AcaEntities::Fdsh::H41::Contracts::MonthlyPremiumInformationContract.params)
            required(:SepPremiumInformation).filled(AcaEntities::Fdsh::H41::Contracts::MonthlyPremiumInformationContract.params)
            required(:OctPremiumInformation).filled(AcaEntities::Fdsh::H41::Contracts::MonthlyPremiumInformationContract.params)
            required(:NovPremiumInformation).filled(AcaEntities::Fdsh::H41::Contracts::MonthlyPremiumInformationContract.params)
            required(:DecPremiumInformation).filled(AcaEntities::Fdsh::H41::Contracts::MonthlyPremiumInformationContract.params)
            required(:AnnualPolicyTotalAmounts).filled(AcaEntities::Fdsh::H41::Contracts::AnnualPolicyTotalAmountsContract.params)
          end
        end
      end
    end
  end
end