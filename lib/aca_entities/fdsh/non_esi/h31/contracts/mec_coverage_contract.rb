# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Contract for FDSH OtherCoverageContract
        class MECCoverageContract < Dry::Validation::Contract
          params do
            optional(:LocationStateUSPostalServiceCode).maybe(AcaEntities::Types::UsStateAbbreviationKind)
            required(:MECVerificationCode).filled(:string)
            required(:Insurances).array(AcaEntities::Fdsh::NonEsi::H31::InsuranceContract.params)
          end
        end
      end
    end
  end
end