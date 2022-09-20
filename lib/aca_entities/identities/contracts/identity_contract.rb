# frozen_string_literal: true

module AcaEntities
  module Identities
    module Contracts
      # Contract for validating a {AcaEntities::Identities::Identity} entity
      class IdentityContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the attributes of an {AcaEntities::Identities::Identity}
        # @option opts [String] :id System-assigned unique identifier
        # @option opts [String] :name The display name - usually a concatenation of first and last name (required)
        # @option opts [Boolean] :enabled Flag indicating whether the user_id is active
        # @option opts [AcaEntities::Contracts::TimeStampContract] :time_stamp Date and time when this record was created and last updated
        # @return [Dry::Monads::Success] if the payload passes validation
        # @return [Dry::Monads::Failure] if the payload fails validation
        params do
          optional(:id).maybe(:string)
          required(:name).filled(:string)
          required(:enabled).filled(:bool)
          optional(:time_stamp).hash(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
