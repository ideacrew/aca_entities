# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for EmployerInfoType
        class EmployerInfoTypeContract < Dry::Validation::Contract
          params do
            required(:employerOrganization).filled(Fdsh::Ridp::H139::OrganizationTypeContract.params)
            optional(:employerAddress).maybe(Fdsh::Ridp::H139::StructuredAddressTypeContract.params)
          end
        end
      end
    end
  end
end