# frozen_string_literal: true

module AcaEntities
  module Contracts
    module People
      # Schema and validation rules for {AcaEntities::People::PersonReference}
      class PersonReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Date] :hbx_id required
        # @option opts [Date] :first_name required
        # @option opts [Boolean] :middle_name optional
        # @option opts [Hash] :last_name required
        # @option opts [Hash] :ssn optional
        # @option opts [Hash] :no_ssn optional
        # @option opts [Hash] :dob required
        # @option opts [Hash] :gender required
        # @return [Dry::Monads::Result]
        params do
          optional(:hbx_id).maybe(:str?)
          required(:first_name).value(:str?)
          optional(:middle_name).maybe(:string)
          required(:last_name).value(:str?)
          optional(:ssn).maybe(:string)
          optional(:encrypted_ssn).maybe(:string)
          optional(:no_ssn).maybe(:bool)
          optional(:dob).maybe(:date)
          required(:gender).maybe(:string)
        end
      end
    end
  end
end