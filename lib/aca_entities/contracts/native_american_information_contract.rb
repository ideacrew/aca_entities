# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for NativeAmericanInformation.
    class NativeAmericanInformationContract < Dry::Validation::Contract

      params do
        required(:is_native_american_or_alaska_native).filled(:bool)
        optional(:indian_tribe_state_code).maybe(Types::IndianTribeStateCode)
        optional(:federally_recognized_tribe).maybe(:bool)
        optional(:tribe_name).maybe(:string)
        optional(:itu_eligible).maybe(:bool)
        optional(:received_ihs).maybe(:bool)
      end
    end
  end
end
