# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for PersonContactInformationAssociation.
      class PersonContactInformationAssociationContract < Dry::Validation::Contract

        params do
          optional(:contact).maybe(:hash)
          optional(:category_code).maybe(:string)
          optional(:is_primary_indicator).maybe(:bool)
        end
      end
    end
  end
end
