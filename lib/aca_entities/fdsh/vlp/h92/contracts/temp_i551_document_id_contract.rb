# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp TempI551DocumentId
        class TempI551DocumentIdContract < Dry::Validation::Contract
          params do
            required(:AlienNumber).filled(:string)
            optional(:PassportCountry).maybe(Fdsh::Vlp::H92::PassportCountryContract.params)
            optional(:DocExpirationDate).maybe(:date)
          end
        end
      end
    end
  end
end