# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for SspdcRequest, commented out fields are from the schema but not expected from us
        class SspdcRequestContract < Dry::Validation::Contract

          params do
            optional(:IndividualId__c).maybe(:integer)

            optional(:SubmitType).maybe(:string) # this should be defaulted to 'Intake'
            optional(:SubmittedBy).maybe(:string)
            optional(:ApplicationReceivedDateTime).maybe(:date_time) # application submission timestamp
            optional(:SSP_Application__c).maybe(:hash)
            optional(:SSP_Member__c).maybe(:array)
            optional(:SSP_Asset__c).maybe(:array)
            optional(:SSP_Benefits__c).maybe(:array)
            #  optional(:SSP_Transaction__c).maybe(:array)
            #  optional(:SSP_ResourceOwnership__c).maybe(:array)
            optional(:SSP_HealthInsuranceFacilityType__c).maybe(:array)
            #  optional(:SSP_Attendance__c).maybe(:array)
            optional(:SSP_Relationship__c).maybe(:array)
            optional(:SSP_ApplicationIndividual__c).maybe(:array)
            optional(:SSP_InsurancePolicy__c).maybe(:array)
            optional(:SSP_InsuranceCoveredIndiv__c).maybe(:array)
            optional(:contact).maybe(:array)
            #  optional(:SSP_TrackDeletion__c).maybe(:array)
            #  optional(:SSP_NoncustodialRelationship__c).maybe(:array)
            #  optional(:SSP_NonCustodialParent__c).maybe(:array)
            #  optional(:accountContactRelation).maybe(:array)
            #  optional(:SSP_AlienSponsor__c).maybe(:array)
          end
        end
      end
    end
  end
end