# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Person employment association contract
      class PersonEmploymentAssociationContract < Dry::Validation::Contract
        params do
          optional(:start_date).maybe(:hash)
          optional(:end_date).maybe(:hash)
          optional(:employer).maybe(:hash)
        end
      end
    end
  end
end