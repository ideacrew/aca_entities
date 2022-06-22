# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for AgencyOrOrganization__r
        class AgencyOrOrganizationRContract < Dry::Validation::Contract
          params do
            optional(:DCDataId__c).maybe(:integer)
          end
        end
      end
    end
  end
end