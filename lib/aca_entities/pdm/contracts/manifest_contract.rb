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
          # required(:type).filled(:string)
          optional(:type).maybe(::AcaEntities::Pdm::Types::ManifestTypes)
          required(:assistance_year).filled(:integer)
          optional(:batch_ids).maybe(:array)
          optional(:file_names).maybe(:array)
          optional(:name).maybe(:string)
          optional(:timestamp).maybe(:date)
          optional(:response).maybe(:string)
          optional(:initial_count).maybe(:integer)
          optional(:generated_count).maybe(:integer)
          optional(:file_generated).maybe(:bool)
        end
      end
    end
  end
end
