# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Contacts
      # Schema and validation rules for {AcaEntities::Contacts::Phone}
      class PhoneContactContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :kind required
        # @option opts [String] :country_code optional
        # @option opts [String] :area_code required
        # @option opts [String] :number required
        # @option opts [String] :extension optional
        # @option opts [String] :primary optional
        # @option opts [String] :full_phone_number optional
        # @return [Dry::Monads::Result]
        params do
          required(:kind).filled(
            AcaEntities::Types::PhoneKind
          )
          required(:primary).filled(:bool)
          required(:area_code).filled(:string)
          required(:number).filled(:string)

          optional(:country_code).maybe(:string)
          optional(:extension).maybe(:string)
          optional(:full_phone_number).maybe(:string)
          optional(:start_on).maybe(:date)
          optional(:end_on).maybe(:date)
        end

        rule(:area_code) do
          key.failure(text: 'should be of length 3 and allows numbers only') if key? && value && !value.match?(/^[0-9]{3}$/)
        end

        rule(:number) do
          key.failure(text: 'should be of length 7 and allows numbers only') if key? && value && !value.match?(/^[0-9]{7}$/)
        end

        rule(:full_phone_number) do
          key.failure(text: 'should be of length 10 and allows numbers only') if key? && value && !value.match?(/^[0-9]{10}$/)
        end
      end
    end
  end
end
