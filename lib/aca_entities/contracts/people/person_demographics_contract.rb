# frozen_string_literal: true

module AcaEntities
  module Contracts
    module People
      # Schema and validation rules for {AcaEntities::People::PersonDemographics}.
      class PersonDemographicsContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Boolean] :is_applying_coverage required
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
          required(:is_applying_coverage).maybe(:bool) # look in consumer role
          required(:ssn).filled(:string)
          required(:no_ssn).filled(:bool)
          required(:gender).filled(:string)
          required(:dob).filled(:date)
          optional(:date_of_death).filled(:date)
          optional(:dob_check).filled(:date)
          required(:is_incarcerated).filled(:bool)
          required(:ethnicity).filled(:array)
          required(:race).filled(:string)
          required(:tribal_id).filled(:string)
          required(:language_code).filled(:string)
        end

        rule(:is_applying_coverage) do
          key.failure(text: 'Incarceration question must be answered') if key? && values[:is_applying_coverage] && values[:is_incarcerated].to_s.blank?
        end
      end
    end
  end
end
