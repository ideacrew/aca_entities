# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for SSP_NonCustodialParent__c
        class SSPNonCustodialParentCContract < Dry::Validation::Contract
          params do
            required(:FirstName__c).filled(:string)
            required(:LastName__c).filled(:string)
            optional(:MiddleInitial__c).maybe(:string)
            optional(:SSN__c).maybe(:string)
            optional(:SuffixCode__c).maybe(:string)
            optional(:IndividualId__c).maybe(:integer)
            optional(:GenderCode__c).maybe(:string)
            optional(:Id).maybe(:string)
            optional(:DCNonCustodialParentId__c).maybe(:integer)
            optional(:DateOfBirth__c).maybe(:date)
            optional(:IsParentUnknown__c).maybe(:bool)
            optional(:RecordType).maybe(:hash)
          end
        end
      end
    end
  end
end