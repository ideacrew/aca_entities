# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for PregnancyInformation.
    class PregnancyInformationContract < Dry::Validation::Contract

      params do
        optional(:is_pregnant).maybe(:bool)
        optional(:expected_children_count).maybe(:integer)
      end
    end
  end
end
