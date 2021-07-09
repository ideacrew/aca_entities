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
          required(:primary).maybe(:bool)
          required(:area_code).filled do
            str? & size?(3) & format?(Types::NumbersOnlyRegex)
          end
          required(:number).filled do
            str? & size?(7) & format?(Types::NumbersOnlyRegex)
          end
          optional(:country_code).maybe(:string)
          optional(:extension).maybe(:string)
          optional(:full_phone_number).maybe do
            str? & size?(10) & format?(Types::NumbersOnlyRegex)
          end
          optional(:start_on).maybe(:date)
          optional(:end_on).maybe(:date)
        end
      end
    end
  end
end
