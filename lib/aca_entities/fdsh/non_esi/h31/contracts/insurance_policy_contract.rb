# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Contract for FDSH VerifyNonEsiMECRequestContract
        class InsurancePolicyContract < Dry::Validation::Contract
          params do
            required(:InsurancePolicyEffectiveDate).filled(:date)
            required(:InsurancePolicyExpirationDate).filled(:date)
          end
        end
      end
    end
  end
end