# frozen_string_literal: true

module AcaEntities
  module Pdm
    module Contracts
      # Schema and validation rules for {AcaEntities::Pdm::ManifestContract}.
      class RequestContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result]
        params do
          required(:subject_id).filled(:string)
          optional(:command).maybe(::AcaEntities::Pdm::Types::RequestCommandTypes)
          optional(:request_payload).maybe(:string)
          optional(:response_payload).maybe(:string)
        end
      end
    end
  end
end
