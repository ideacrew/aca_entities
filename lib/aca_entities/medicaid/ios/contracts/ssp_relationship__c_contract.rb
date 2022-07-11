# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for SSPRelationshipC
        class SSPRelationshipCContract < Dry::Validation::Contract
          params do
            optional(:SSP_MemberRelatedTo__c).maybe(:string)
            optional(:SSP_Member__c).maybe(:string)
            optional(:DCId__c).maybe(:integer)
            optional(:Id).maybe(:string)
            optional(:IntendToPursueLegalCustodyToggle__c).maybe(:string)
            required(:RelationshipType__c).filled(:string)
            optional(:IsActingParentToggle__c).maybe(:string)
            optional(:IsCareTakerToggle__c).maybe(:string)
            optional(:IndividualId__c).maybe(:integer)
            optional(:SSP_Member__r).maybe(:hash)
          end
        end
      end
    end
  end
end