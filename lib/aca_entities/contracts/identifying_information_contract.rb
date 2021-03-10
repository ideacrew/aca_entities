# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for IdentifyingInformation.
    class IdentifyingInformationContract < Dry::Validation::Contract

      params do
        optional(:ssn).maybe(:string)
        optional(:hbx_id).maybe(:string)
      end
    end
  end
end
