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
          required(:hbx_id).filled(:string)
          required(:first_name).filled(:string)
          optional(:middle_name).maybe(:string)
          required(:last_name).filled(:string)
          optional(:ssn).maybe(:string)
          optional(:no_ssn).maybe(:bool)
          required(:dob).filled(:date)
          required(:gender).filled(:string)
        end
      end
    end
  end
end