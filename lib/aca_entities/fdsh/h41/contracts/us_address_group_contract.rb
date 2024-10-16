# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for H41 UsAddressGroupContract
        class UsAddressGroupContract < Dry::Validation::Contract
          params do
            required(:AddressLine1Txt).filled(:string)
            optional(:AddressLine2Txt).maybe(:string)
            required(:CityNm).filled(:string)
            required(:USStateCd).filled(:string)
            required(:USZIPCd).filled(:string)
            optional(:USZIPExtensionCd).maybe(:string)
          end
        end
      end
    end
  end
end