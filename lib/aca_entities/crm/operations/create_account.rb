# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  # Customer Relationship Management (CRM) entities
  module Crm
    # Operations related to CRM entities
    module Operations
      # Operation to create a CRM account entity from a hash of attributes.
      # Validates the input parameters using the AccountContract and expects
      # the account to have a list of contacts.
      class CreateAccount
        include Dry::Monads[:do, :result]

        # Calls the operation to create an account
        #
        # @param params [Hash] the parameters to create an account with
        # @option params [String] :account_name The name of the account
        # @option params [Array<Hash>] :contacts A list of contacts associated with the account
        # @return [Dry::Monads::Result] Success or Failure
        def call(params)
          values = yield validate_params(params)
          family = yield create_account(values)

          Success(family)
        end

        private

        # Validates the input parameters using the AccountContract
        #
        # @param params [Hash] the parameters to validate
        # @return [Dry::Monads::Result] Success with validated parameters or Failure with errors
        def validate_params(params)
          result = ::AcaEntities::Crm::Contracts::AccountContract.new.call(params)

          if result.success?
            Success(result.to_h)
          else
            Failure(result.errors.to_h)
          end
        end

        # Creates an account entity with the validated values
        #
        # @param values [Hash] the validated account values
        # @return [Dry::Monads::Result] Success with the created Account entity
        def create_account(values)
          Success(::AcaEntities::Crm::Account.new(values))
        end
      end
    end
  end
end
