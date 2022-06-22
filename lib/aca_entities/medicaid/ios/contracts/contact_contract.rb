# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for Contact
        class ContactContract < Dry::Validation::Contract
          params do
            optional(:AddressTypeCode__c).maybe(:string)
            optional(:AgencyEmployeeId__c).maybe(:integer)
            optional(:AssociationStartDate__c).maybe(:date)
            optional(:Birthdate).maybe(:date)
            optional(:Email).maybe(:string)
            required(:FirstName).filled(:string)
            required(:LastName).filled(:string)
            optional(:GenderCode__c).maybe(:string)
            optional(:MailingAddressLine2__c).maybe(:string)
            optional(:OrganizationName__c).maybe(:string)
            optional(:OrgranizationIdentificationNumber__c).maybe(:string)
            optional(:PreferredLanguageCode__c).maybe(:string)
            optional(:PrimaryPhoneExtension__c).maybe(:integer)
            optional(:PrimaryPhoneNumber__c).maybe(:string)
            optional(:RepresentativeProgramCode__c).maybe(:string)
            optional(:SSN__c).maybe(:string)
            optional(:SuffixCode__c).maybe(:string)
            optional(:IndividualId__c).maybe(:string)
            optional(:Id).maybe(:string)
            optional(:MiddleName).maybe(:string)
            optional(:Phone).maybe(:string)
            optional(:DCDataId__c).maybe(:integer)
            optional(:PreferredLanguageCode__c).maybe(:string)
            optional(:IsManualAuthRep__c).maybe(:bool)
            optional(:RecordType).maybe(:hash)
            optional(:AgencyOrOrganization__r).maybe(:hash)
          end

          rule(:MailingAddressLine2__c) do
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