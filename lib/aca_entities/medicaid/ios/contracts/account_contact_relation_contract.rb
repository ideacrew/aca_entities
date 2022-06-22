# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for AccountContactRelationContract
        class AccountContactRelationContract < Dry::Validation::Contract
          params do
            optional(:DCRepresentativeId__c).maybe(:integer)
            optional(:DCContactId__c).maybe(:integer)
            optional(:DCAgencyId__c).maybe(:integer)
            optional(:DCDataId__c).maybe(:integer)
            optional(:IsRepresentativeVerified__c).maybe(:string)
            required(:AddressLine1__c).filled(:string)
            optional(:AddressLine2__c).maybe(:string)
            optional(:Street__c).maybe(:string)
            required(:City__c).filled(:string)
            required(:StateCode__c).filled(:string)
            optional(:Zipcode5__c).maybe(:string)
            optional(:Zipcode4__c).maybe(:string)
            optional(:CountyCode__c).maybe(:string)
            optional(:IsAddressValidated__c).maybe(:bool)
            optional(:ContactId).maybe(:string)
            optional(:Id).maybe(:string)
            optional(:Roles).maybe(:string)
            optional(:ProgramsApplied__c).maybe(:string)
            optional(:PermissionLevel_Medicaid__c).maybe(:string)
            optional(:PermissionLevel_SNAP__c).maybe(:string)
            optional(:PermissionLevel_StateSupp__c).maybe(:string)
            optional(:PermissionLevel_KIHIPP__c).maybe(:string)
            optional(:PermissionLevel_KTAP__c).maybe(:string)
            optional(:PermissionLevel_CCAP__c).maybe(:string)
            optional(:StartDate).maybe(:date)
            optional(:RepresentativeRelationshipCode__c).maybe(:string)
            required(:Contact).filled(:hash)

          end

          rule(:AddressLine2__c) do
            if key && value && value.match(%r{[^a-zA-Z\d\s.,#-‘&/]})
              key.failure(text: "invalid address line 2 - Only letters, numbers and the following special characters are allowed: (. , # - ‘ & /)",
                          error: result.errors.to_h)
            end
          end
        end
      end
    end
  end
end
