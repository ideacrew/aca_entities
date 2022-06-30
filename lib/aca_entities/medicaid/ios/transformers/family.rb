# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Medicaid
    module Ios
      module Transformers
        # CV3 Family transform to IOS payload format
        class Family < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          namespace 'family' do
            rewrap 'SspdcRequest', type: :hash do
              # map '???', 'IndividualId__c'
              # map '???', 'SubmitType'
              # map '???', 'SubmittedBy'
              # map '???', 'ApplicationReceivedDateTime'
              # map '???', 'SSP_Application__c', function: Application Builder or Transformer?

              # namespace '???' do
              #   rewrap 'SSP_Member__c', type: :array do
              #     rewrap '', type: :hash do
                      # map SSP_Member__c fields
              #     end
              #   end
              # end
              #  *** OR ***
              # add_key 'SSP_Member__c', function: AcaEntities::Atp::Functions::SSPMemberBuilder.new
            
              # namespace '???' do
              #   rewrap 'SSP_Asset__c', type: :array do
              #     rewrap '', type: :hash do
                      # map SSP_Member__c fields
                      # RecordType is nested in here
              #     end
              #   end
              # end
              #  *** OR ***
              # add_key 'SSP_Asset__c', function: AcaEntities::Atp::Functions::SSPAssetCBuilder.new  <- RecordType is nested in here

              # namespace '???' do
              #   rewrap 'SSP_Benefits__c', type: :array do
              #     rewrap '', type: :hash do
                      # map SSP_Benefits__c fields
                      # RecordType is nested in here
                      # SSP_Member__r is nested in here
              #     end
              #   end
              # end
              #  *** OR ***
              # add_key 'SSP_Benefits__c', function: AcaEntities::Atp::Functions::SSPBeneftsCBuilder.new <- RecordType, SSP_Member__r is nested in here

              # namespace '???' do
              #   rewrap 'SSP_HealthInsuranceFacilityType__c', type: :array do
              #     rewrap '', type: :hash do
                      # map SSP_HealthInsuranceFacilityType__c fields
              #     end
              #   end
              # end
              #  *** OR ***
              # add_key 'SSP_HealthInsuranceFacilityType__c', function: AcaEntities::Atp::Functions::SSPHealthInsuranceFacilityTypeCBuilder.new

              # namespace '???' do
              #   rewrap 'SSP_Relationship__c', type: :array do
              #     rewrap '', type: :hash do
                      # map SSP_Relationship__c fields
                      # SSP_Member__r is nested in here
              #     end
              #   end
              # end
              #  *** OR ***
              # add_key 'SSP_Relationship__c', function: AcaEntities::Atp::Functions::SSPRelationshipCBuilder.new <- SSP_Member__r is nested in here


              # namespace '???' do
              #   rewrap 'SSP_ApplicationIndividual__c', type: :array do
              #     rewrap '', type: :hash do
                      # map SSP_ApplicationIndividual__c fields
                      # SSP_Member__r is nested in here
              #     end
              #   end
              # end
              #  *** OR ***
              # add_key 'SSP_ApplicationIndividual__c', function: AcaEntities::Atp::Functions::SSPApplicationIndividualCBuilder.new <- SSP_Member__r is nested in here
              
              # namespace '???' do
              #   rewrap 'SSP_InsurancePolicy__c', type: :array do
              #     rewrap '', type: :hash do
                      # map SSP_InsurancePolicy__c fields
              #     end
              #   end
              # end
              #  *** OR ***
              # add_key 'SSP_InsurancePolicy__c', function: AcaEntities::Atp::Functions::SSPInsurancePolicyCBuilder.new 

              # namespace '???' do
              #   rewrap 'SSP_InsuranceCoveredIndiv__c', type: :array do
              #     rewrap '', type: :hash do
                      # map SSP_InsuranceCoveredIndiv__c fields
                      # RecordType is nested in here
                      # SSP_Member__r is nested in here
              #     end
              #   end
              # end
              #  *** OR ***
              # add_key 'SSP_InsuranceCoveredIndiv__c', function: AcaEntities::Atp::Functions::SSPInsuranceCoveredIndivCBuilder.new <- RecordType, SSP_Member__r is nested in here 

              # namespace '???' do
              #   rewrap 'contact', type: :array do
              #     rewrap '', type: :hash do
                      # map contact fields
                      # RecordType is nested in here
                      # AgencyOrOrganization__r is nested in here
              #     end
              #   end
              # end
              #  *** OR ***
              # add_key 'contact', function: AcaEntities::Atp::Functions::ContactBuilder.new <- RecordType, AgencyOrOrganization__r is nested in here 

              # AccountContactRelation
                # DCRepresentativeId__c
                # DCContactId__c
                # DCAgencyId__c
                # DCDataId__c
                # IsRepresentativeVerified__c
                # AddressLine1__c
                # AddressLine2__c
                # Street__c
                # City__c
                # StateCode__c
                # Zipcode5__c
                # Zipcode4__c
                # CountyCode__c
                # IsAddressValidated__c
                # ContactId
                # Id
                # Roles
                # ProgramsApplied__c
                # PermissionLevel_Medicaid__c
                # PermissionLevel_SNAP__c
                # PermissionLevel_StateSupp__c
                # PermissionLevel_KIHIPP__c
                # PermissionLevel_KTAP__c
                # PermissionLevel_CCAP__c
                # StartDate
                # RepresentativeRelationshipCode__c
                # Contact
              # AgencyOrOrganization__r
              # Contact
              # RecordType
              # SSP_Application__c
              # SSP_ApplicationIndividual__c
              # SSP_Asset__c
              # SSP_Benefits__c
              # SSP_HealthInsuranceFacilityType__c
              # SSP_InsuranceCoveredIndiv__c
              # SSP_InsurancePolicy__c
              # SSP_Member__c
              # SSP_Member__r
              # SSP_Relationship__c
              

              # AccountContactRelation
              # SSP_NonCustodialParent__c



              # ***NOTE***
              # SSP_Member__c nests TaxFilerMemberCurrent__r and RecordType

  
            end
          end
        end
      end
    end
  end
end