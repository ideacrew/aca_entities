# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for SsaInformation.
    class SsaInformationContract < Dry::Validation::Contract

      params do
        optional(:is_person_alive).maybe(:bool)
      end
    end
  end
end
