# frozen_string_literal: true

# Include the baseline contracts, entities and types of Magi In The Cloud
module AcaEntities
  module MagiMedicaid
    module Libraries
      module MitcLibrary
        require 'aca_entities/app_helper'
        require 'aca_entities/magi_medicaid/mitc/types'
        require 'aca_entities/magi_medicaid/mitc/contracts/request_contract'

        require 'aca_entities/magi_medicaid/mitc/person_reference'
        require 'aca_entities/magi_medicaid/mitc/category_determination'
        require 'aca_entities/magi_medicaid/mitc/deprived_child'
        require 'aca_entities/magi_medicaid/mitc/household'
        require 'aca_entities/magi_medicaid/mitc/medicaid_household'
        require 'aca_entities/magi_medicaid/mitc/income'
        require 'aca_entities/magi_medicaid/mitc/relationship'
        require 'aca_entities/magi_medicaid/mitc/person'
        require 'aca_entities/magi_medicaid/mitc/tax_return'
        require 'aca_entities/magi_medicaid/mitc/qualified_child'
        require 'aca_entities/magi_medicaid/mitc/applicant'
        require 'aca_entities/magi_medicaid/mitc/eligibility_response'
        require 'aca_entities/magi_medicaid/mitc/application'

        require 'aca_entities/magi_medicaid/mitc/contracts/person_reference_contract'
        require 'aca_entities/magi_medicaid/mitc/contracts/category_determination_contract'
        require 'aca_entities/magi_medicaid/mitc/contracts/deprived_child_contract'
        require 'aca_entities/magi_medicaid/mitc/contracts/household_contract'
        require 'aca_entities/magi_medicaid/mitc/contracts/medicaid_household_contract'
        require 'aca_entities/magi_medicaid/mitc/contracts/income_contract'
        require 'aca_entities/magi_medicaid/mitc/contracts/relationship_contract'
        require 'aca_entities/magi_medicaid/mitc/contracts/person_contract'
        require 'aca_entities/magi_medicaid/mitc/contracts/tax_return_contract'
        require 'aca_entities/magi_medicaid/mitc/contracts/qualified_child_contract'
        require 'aca_entities/magi_medicaid/mitc/contracts/applicant_contract'
        require 'aca_entities/magi_medicaid/mitc/contracts/eligibility_response_contract'
        require 'aca_entities/magi_medicaid/mitc/contracts/application_contract'
      end
    end
  end
end
