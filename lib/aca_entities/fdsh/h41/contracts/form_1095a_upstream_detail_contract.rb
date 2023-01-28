# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for H41 Form1095aUpstreamDetailContract
        class Form1095aUpstreamDetailContract < Dry::Validation::Contract
          params do
            required(:RecordSequenceNum).filled(:string)
            required(:TaxYr).filled(:string)
            required(:CorrectedInd).filled(:string)
            optional(:CorrectedRecordSequenceNum).maybe(:string)
            required(:VoidInd).filled(:string)
            optional(:VoidedRecordSequenceNum).maybe(:string)
            required(:MarketplaceId).filled(:string)
            required(:Policy).filled(AcaEntities::Fdsh::H41::Contracts::PolicyContract.params)
            required(:Recipient).filled(AcaEntities::Fdsh::H41::Contracts::RecipientContract.params)
            optional(:RecipientSpouse).maybe(AcaEntities::Fdsh::H41::Contracts::RecipientSpouseContract.params)
            required(:CoverageHouseholdGrp).filled(AcaEntities::Fdsh::H41::Contracts::CoverageHouseholdGroupContract.params)
            required(:RecipientPolicyInformation).filled(AcaEntities::Fdsh::H41::Contracts::RecipientPolicyInformationContract.params)
          end
        end
      end
    end
  end
end