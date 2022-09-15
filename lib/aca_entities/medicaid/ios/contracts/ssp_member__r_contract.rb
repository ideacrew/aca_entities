# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for SSP_Member__r
        class SspMemberRContract < Dry::Validation::Contract

          params do
            required(:IsFixedAddressToggle__c).filled(:string)
            required(:In_Which_City_Town_Applicant_Live__c).filled(:string)
            required(:FirstName__c).filled(:string)
            required(:LastName__c).filled(:string)
            optional(:PhysicalCity__c).filled(:string)
            optional(:PhysicalStateCode__c).maybe(:string)
            optional(:PhysicalZipCode5__c).maybe(:string)
            optional(:PhysicalAddressLine2__c).maybe(:string)
            required(:BirthDate__c).filled(:string)
            required(:GenderCode__c).filled(:string)
            required(:IsHispanicLatinoSpanishToggle__c).filled(:string)
            required(:IsIntendToResideToggle__c).filled(:string)
            optional(:MiddleInitial__c).maybe(:string)
            optional(:SuffixCode__c).maybe(:string)
            optional(:RaceCode__c).maybe(:string)
            optional(:NoReasonSSNCode__c).maybe(:string)
            optional(:SSN__c).maybe(:string)
            optional(:IsMilitaryMemberToggle__c).maybe(:string)
            optional(:HasSSN__c).maybe(:string)
          end
        end
      end
    end
  end
end