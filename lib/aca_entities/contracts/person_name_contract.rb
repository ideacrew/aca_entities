# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Schema and validation rules for {AcaEntities::MagiMedicaid::PersonName}
    class PersonNameContract < Dry::Validation::Contract
      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [String] :first_name required
      # @option opts [String] :middle_name optional
      # @option opts [String] :last_name required
      # @option opts [String] :name_sfx optional
      # @option opts [String] :name_pfx optional
      # @option opts [Date] :start_on optional
      # @option opts [Date] :end_on optional
      # @return [Dry::Monads::Result]
      params do
        required(:first_name).filled(:string)
        optional(:middle_name).maybe(:string)
        required(:last_name).filled(:string)
        optional(:name_sfx).maybe(:string)
        optional(:name_pfx).maybe(:string)
        optional(:start_on).maybe(:date)
        optional(:end_on).maybe(:date)
      end
    end
  end
end
