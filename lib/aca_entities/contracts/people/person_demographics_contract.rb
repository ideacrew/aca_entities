# frozen_string_literal: true

module AcaEntities
  module Contracts
    module People
      # Schema and validation rules for {AcaEntities::People::PersonDemographics}.
      class PersonDemographicsContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :ssn required
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
        # @return [Dry::Monads::Result]
        params do
          required(:ssn).filled(:string)
          required(:no_ssn).filled(:bool)
          required(:gender).filled(:string)
          required(:dob).filled(:date)
          optional(:date_of_death).filled(:date)
          optional(:dob_check).filled(:date)
          required(:is_incarcerated).filled(:bool)
          optional(:ethnicity).filled(:array)
          optional(:race).filled(:string)
          optional(:tribal_id).filled(:string)
          optional(:language_code).filled(:string)
        end
      end
    end
  end
end
