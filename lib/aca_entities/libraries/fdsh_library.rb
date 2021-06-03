# frozen_string_literal: true

# Include the baseline entities and types of fdsh
module AcaEntities
  module Libraries
    module FdshLibrary

      # contracts
      require 'aca_entities/types'
      require 'aca_entities/fdsh/ridp/h139/types'
      require 'aca_entities/fdsh/ridp/h139/contracts/initial_service_request_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/initial_service_response_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/subsequent_service_request_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/subsequent_service_response_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/fars_request_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/fars_response_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/verification_metadata_type_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/response_metadata_type_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/person_type_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/structured_address_type_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/organization_type_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/person_employment_association_type_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/employment_info_type_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/employer_info_type_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/income_type_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/pay_period_information_type_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/annual_compensation_information_type_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/annual_composition_type_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/app_info_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/base_compensation_info_type_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/current_household_income_type_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/current_income_info_type_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/current_income_request_payload_type_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/current_income_response_contract'
      require 'aca_entities/fdsh/ridp/h139/contracts/current_income_response_payload_type_contract'

      # entities
      require 'aca_entities/fdsh/ridp/h139/initial_service_request'
      require 'aca_entities/fdsh/ridp/h139/initial_service_response'
      require 'aca_entities/fdsh/ridp/h139/subsequent_service_request'
      require 'aca_entities/fdsh/ridp/h139/subsequent_service_response'
      require 'aca_entities/fdsh/ridp/h139/fars_request'
      require 'aca_entities/fdsh/ridp/h139/fars_response'
      require 'aca_entities/fdsh/ridp/h139/verification_metadata_type'
      require 'aca_entities/fdsh/ridp/h139/response_metadata_type'
      require 'aca_entities/fdsh/ridp/h139/person_type'
      require 'aca_entities/fdsh/ridp/h139/structured_address_type'
      require 'aca_entities/fdsh/ridp/h139/organization_type'
      require 'aca_entities/fdsh/ridp/h139/person_employment_association_type'
      require 'aca_entities/fdsh/ridp/h139/employment_info_type'
      require 'aca_entities/fdsh/ridp/h139/employer_info_type'
      require 'aca_entities/fdsh/ridp/h139/income_type'
      require 'aca_entities/fdsh/ridp/h139/pay_period_information_type'
      require 'aca_entities/fdsh/ridp/h139/annual_compensation_information_type'
      require 'aca_entities/fdsh/ridp/h139/annual_composition_type'
      require 'aca_entities/fdsh/ridp/h139/app_info'
      require 'aca_entities/fdsh/ridp/h139/base_compensation_info_type'
      require 'aca_entities/fdsh/ridp/h139/current_household_income_type'
      require 'aca_entities/fdsh/ridp/h139/current_income_info_type'
      require 'aca_entities/fdsh/ridp/h139/current_income_request_payload_type'
      require 'aca_entities/fdsh/ridp/h139/current_income_response'
      require 'aca_entities/fdsh/ridp/h139/current_income_response_payload_type'

    end
  end
end