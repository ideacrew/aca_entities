# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'aca_entities/medicaid/ios/transformers/application'
require 'aca_entities/medicaid/ios/functions/ssp_member__c_builder'
require 'aca_entities/medicaid/ios/functions/ssp_asset__c_builder'
require 'aca_entities/medicaid/ios/functions/ssp_benefits__c_builder'
require 'aca_entities/medicaid/ios/functions/ssp_application_individual__c_builder'
require 'aca_entities/medicaid/ios/functions/ssp_insurance_policy__c_builder'
require 'aca_entities/medicaid/ios/functions/ssp_insurance_covered_indiv__c_builder'
require 'aca_entities/medicaid/ios/functions/contact_builder'

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

              map 'magi_medicaid_applications', '', memoize_record: true, visible: false
              add_key 'SSP_Application__c', function: lambda { |v|
                appplication_hash = v.resolve('family.magi_medicaid_applications').item
                AcaEntities::Medicaid::Ios::Transformers::Application.transform(appplication_hash)
              }
              add_key 'SSP_Member__c', function: AcaEntities::Medicaid::Ios::Functions::SspMemberCBuilder.new

              # RecordType is nested in SSP_Asset__c
              add_key 'SSP_Asset__c', function: AcaEntities::Medicaid::Ios::Functions::SspAssetCBuilder.new

              # RecordType, SSP_Member__r is nested in SSP_Benefits__c
              add_key 'SSP_Benefits__c', function: AcaEntities::Medicaid::Ios::Functions::SspBenefitsCBuilder.new

              # namespace '???' do
              #   rewrap 'SSP_HealthInsuranceFacilityType__c', type: :array do
              #     rewrap '', type: :hash do
              # map SSP_HealthInsuranceFacilityType__c fields
              #     end
              #   end
              # end

              # namespace '???' do
              #   rewrap 'SSP_Relationship__c', type: :array do
              #     rewrap '', type: :hash do
              # map SSP_Relationship__c fields
              # SSP_Member__r is nested in here
              #     end
              #   end
              # end

              # SSP_Member__r is nested in SSP_ApplicationIndividual__c
              add_key 'SSP_ApplicationIndividual__c', function: AcaEntities::Medicaid::Ios::Functions::SspApplicationIndividualCBuilder.new

              add_key 'SSP_InsurancePolicy__c', function: AcaEntities::Medicaid::Ios::Functions::SspInsurancePolicyCBuilder.new

              # RecordType, SSP_Member__r is nested in SSP_InsuranceCoveredIndiv__c
              add_key 'SSP_InsuranceCoveredIndiv__c', function: AcaEntities::Medicaid::Ios::Functions::SspInsuranceCoveredIndivCBuilder.new

              # RecordType, AgencyOrOrganization__r is nested in contact
              add_key 'contact', function: AcaEntities::Medicaid::Ios::Functions::ContactBuilder.new

              # ***NOTE***
              # SSP_Member__c nests TaxFilerMemberCurrent__r and RecordType

            end
          end
        end
      end
    end
  end
end