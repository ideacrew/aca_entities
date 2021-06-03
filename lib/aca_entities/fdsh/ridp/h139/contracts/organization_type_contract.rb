# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for OrganizationType
        class OrganizationTypeContract < Dry::Validation::Contract
          params do
            required(:organization_identification).filled(:string)
            required(:organization_name).filled(:string)
          end
        end
      end
    end
  end
end