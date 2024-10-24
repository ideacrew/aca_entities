# frozen_string_literal: true

module AcaEntities
  module Contracts
    module People
      # Schema and validation rules for {AcaEntities::People::PersonDemographics}.
      class PersonDemographicsContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :ssn optional
        # @option opts [Boolean] :no_ssn required
        # @option opts [String] :gender required
        # @option opts [Date] :dob required
        # @option opts [Date] :date_of_death optional
        # @option opts [Date] :dob_check optional
        # @option opts [Boolean] :is_incarcerated required
        # @option opts [Array] :ethnicity required
        # @option opts [String] :race required
        # @option opts [String] :tribal_id required
        # @option opts [String] :language_code required
        # @option opts [Hash] :alive_status optional
        # @return [Dry::Monads::Result]
        params do
          optional(:ssn).maybe(:string)
          optional(:encrypted_ssn).maybe(:string)
          optional(:no_ssn).maybe(:bool)
          required(:gender).value(:str?)
          required(:dob).filled(:date)
          optional(:date_of_death).maybe(:date)
          optional(:dob_check).maybe(:bool)
          optional(:is_incarcerated).maybe(:bool)
          optional(:ethnicity).maybe(:array)
          optional(:race).maybe(:string)
          optional(:indian_tribe_member).maybe(:bool)
          optional(:tribal_id).maybe(:string)
          optional(:tribal_state).maybe(:string)
          optional(:tribal_name).maybe(:string)
          optional(:language_code).maybe(:string)

          # @!attribute [r] alive_status
          #   @return [AcaEntities::Contracts::People::AliveStatusContract.params, nil] the alive status of a person
          #   @note This attribute is optional and can be omitted.
          optional(:alive_status).maybe(
            AcaEntities::Contracts::People::AliveStatusContract.params
          )
        end
      end
    end
  end
end
