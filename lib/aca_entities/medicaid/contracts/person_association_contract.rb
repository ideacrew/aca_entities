# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for PersonAssociation.
      class PersonAssociationContract < Dry::Validation::Contract

        params do
          optional(:person).maybe(:hash)
          optional(:family_relationship_code).maybe(:string)
        end
      end
    end
  end
end
