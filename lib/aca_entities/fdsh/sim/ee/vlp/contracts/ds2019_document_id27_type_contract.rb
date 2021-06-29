# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp Ds2019DocumentId27Type
          class Ds2019DocumentId27TypeContract < Dry::Validation::Contract
            params do
              required(:sevisid).filled(:string)
              optional(:i94Number).maybe(:string)
              optional(:passportCountry).maybe(Fdsh::Sim::Ee::Vlp::PassportCountryTypeContract.params)
              optional(:docExpirationDate).maybe(:string)
            end
          end
        end
      end
    end
  end
end