# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for PregnancyInformation.
      class PregnancyInformationContract < Dry::Validation::Contract

        params do
          optional(:is_pregnant).maybe(:bool)
          optional(:expected_children_count).maybe(:integer)
        end

        rule(:is_pregnant) do
          if key?
            # required if applyingForCoverage =Y , age between 9 and 66 and Sex Name = Female.
          end
        end
      end
    end
  end
end
