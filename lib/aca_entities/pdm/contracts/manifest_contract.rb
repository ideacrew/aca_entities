# frozen_string_literal: true

module AcaEntities
  module Pdm
    module Contracts
      # Schema and validation rules for {AcaEntities::Pdm::ManifestContract}.
      class ManifestContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result]
        params do
          required(:type).filled(:string)
          required(:assistance_year).filled(:integer)
          optional(:batch_id).maybe(:string)
          optional(:name).maybe(:string)
          optional(:timestamp).maybe(:date)
          optional(:response).maybe(:string)
          optional(:count).maybe(:integer)
        end
      end
    end
  end
end
