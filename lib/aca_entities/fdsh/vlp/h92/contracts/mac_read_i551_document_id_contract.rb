# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp MacReadI551DocumentId
        class MacReadI551DocumentIdContract < Dry::Validation::Contract
          params do
            required(:AlienNumber).filled(:string)
            required(:PassportNumber).filled(:string)
            required(:CountryOfIssuance).filled(:string)
            optional(:VisaNumber).maybe(:string)
            optional(:DocExpirationDate).maybe(:date)
          end
        end
      end
    end
  end
end