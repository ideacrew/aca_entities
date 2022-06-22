# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      # entity for SspdcRequest, commented out fields are from the schema but not expected from us
      class SSPDCRequest < Dry::Struct
        attribute :SubmitType, Types::String.optional.meta(omittable: true) # this should be defaulted to 'Intake'
        attribute :SubmittedBy, Types::String.optional.meta(omittable: true)
        attribute :ApplicationReceivedDateTime, Types::DateTime.optional.meta(omittable: true) # application submission timestamp
        attribute :SSP_Application__c, SSPApplicationC.meta(omittable: true)
        attribute :SSP_Member__c, Types::Array.of(SSPMemberC).optional.meta(omittable: true)
        attribute :SSP_Asset__c, Types::Array.of(SSPAssetC).optional.meta(omittable: true)
        attribute :SSP_Benefits__c, Types::Array.of(SSPBenefitsC).optional.meta(omittable: true)
        # attribute :SSP_Transaction__c, Types::Array.of(SSP_Transaction__c).optional.meta(omittable: true)
        # attribute :SSP_ResourceOwnership__c, Types::Array.of(SSP_ResourceOwnership__c).optional.meta(omittable: true)
        attribute :SSP_HealthInsuranceFacilityType__c, Types::Array.of(SSPHealthInsuranceFacilityTypeC).optional.meta(omittable: true)
        # attribute :SSP_Attendance__c, Types::Array.of(SSP_Attendance__c).optional.meta(omittable: true)
        attribute :SSP_Relationship__c, Types::Array.of(SSPRelationshipC).optional.meta(omittable: true)
        attribute :SSP_ApplicationIndividual__c, Types::Array.of(SSPApplicationIndividualC).optional.meta(omittable: true)
        attribute :SSP_InsurancePolicy__c, Types::Array.of(SSPInsurancePolicyC).optional.meta(omittable: true)
        attribute :SSP_InsuranceCoveredIndiv__c, Types::Array.of(SSPInsuranceCoveredIndivC).optional.meta(omittable: true)
        attribute :contact, Types::Array.of(Contact).optional.meta(omittable: true)
        # attribute :SSP_TrackDeletion__c, Types::Array.of(SSP_TrackDeletion__c).optional.meta(omittable: true)
        # attribute :SSP_NoncustodialRelationship__c, Types::Array.of(SSP_NoncustodialRelationship__c).optional.meta(omittable: true)
        # attribute :SSP_NonCustodialParent__c, Types::Array.of(SSP_NonCustodialParent__c).optional.meta(omittable: true)
        # attribute :accountContactRelation, Types::Array.of(accountContactRelation).optional.meta(omittable: true)
        # attribute :SSP_AlienSponsor__c, Types::Array.of(SSP_AlienSponsor__c).optional.meta(omittable: true)
      end
    end
  end
end