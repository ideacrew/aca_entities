# frozen_string_literal: true

# types
require 'aca_entities/types'
# require_relative 'ios/types'

# contracts
require_relative "ios/contracts/record_type_contract"
require_relative "ios/contracts/agency_or_organization__r_contract"
require_relative "ios/contracts/contact_contract"
require_relative "ios/contracts/account_contact_relation_contract"
require_relative "ios/contracts/ssp_application__c_contract"
require_relative "ios/contracts/ssp_application_individual__c_contract"
require_relative "ios/contracts/ssp_asset__c_contract"
require_relative "ios/contracts/ssp_member__r_contract"
require_relative "ios/contracts/ssp_relationship__c_contract"
require_relative "ios/contracts/tax_filer_member_current__r_contract"
require_relative "ios/contracts/ssp_noncustodialparent__c_contract"
require_relative "ios/contracts/ssp_benefits__c_contract"
require_relative "ios/contracts/ssp_insurance_covered_indiv__c_contract"
require_relative "ios/contracts/ssp_health_insurance_facility_type__c_contract"
require_relative "ios/contracts/ssp_insurance_policy__c_contract"
require_relative "ios/contracts/sspdc_request_contract"

# entities -> for reference only, to be cleaned up and removed once contracts have been built
# require_relative "ios/agency_or_organization__r"
# require_relative "ios/tax_filer_member_current__r"
# require_relative "ios/sspdc_request"
# require_relative "ios/ssp_relationship__c"
# require_relative "ios/ssp_noncustodialparent__c"
# require_relative "ios/ssp_member__r"
# require_relative "ios/ssp_member__c"
# require_relative "ios/ssp_insurance_covered_indiv__c"
# require_relative "ios/ssp_health_insurance_facility_type__c"
# require_relative "ios/ssp_benefits__c"
# require_relative "ios/ssp_asset__c"
# require_relative "ios/ssp_application_individual__c"
# require_relative "ios/ssp_application__c"
# require_relative "ios/record_type"
# require_relative "ios/contact"

# transformers
# require_relative 'ios/transformers/cv3_to_ios'

# operations
# file name TBD require_relative 'ios/operations/prep_data'
require_relative 'ios/operations/generate_ios'

module AcaEntities
  module Medicaid
    # Domain objects representing IOS payload
    module Ios
    end
  end
end
