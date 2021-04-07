# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::ApplicationReference}
      class ApplicationReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :hbx_id required
        # @return [Dry::Monads::Result]
        params do
          required(:hbx_id).filled(:string)
        end
      end
    end
  end
end
