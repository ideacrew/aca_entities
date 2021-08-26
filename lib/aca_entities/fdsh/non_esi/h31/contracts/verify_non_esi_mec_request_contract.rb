# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Contract for FDSH VerifyNonEsiMECRequestContract
        class VerifyNonESIMECRequestContract < Dry::Validation::Contract
          params do
            required(:IndividualRequests).array(AcaEntities::Fdsh::NonEsi::H31::IndividualRequestContract.params)
          end
        end
      end
    end
  end
end