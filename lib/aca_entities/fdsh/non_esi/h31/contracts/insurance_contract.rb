# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Contract for FDSH InsuranceContract
        class InsuranceContract < Dry::Validation::Contract
          params do
            required(:InsuranceEffectiveDate).filled(AcaEntities::Fdsh::NonEsi::H31::InsuranceDateContract.params)
            required(:InsuranceEndDate).filled(AcaEntities::Fdsh::NonEsi::H31::InsuranceDateContract.params)
          end
        end
      end
    end
  end
end