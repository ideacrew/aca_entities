# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for SSPRelationshipC
        class SSPRelationshipCContract < Dry::Validation::Contract
          params do
            required(:RelationshipType__c).filled(:string)
            optional(:Id).maybe(:string)
            optional(:IsCareTakerToggle__c).maybe(:string)
            optional(:SSP_Member__c).maybe(:string)
            optional(:SSP_MemberRelatedTo__c).maybe(:string)
          end
        end
      end
    end
  end
end