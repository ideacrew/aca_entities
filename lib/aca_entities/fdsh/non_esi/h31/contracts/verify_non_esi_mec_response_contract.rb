# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Contract for FDSH VerifyNonEsiMECResponseContract
        class VerifyNonESIMECResponseContract < Dry::Validation::Contract
          params do
            optional(:ResponseMetadata).maybe(AcaEntities::Fdsh::NonEsi::H31::ResponseMetadataContract.params)
            optional(:IndividualResponseSet).maybe(AcaEntities::Fdsh::NonEsi::H31::IndividualResponseSetContract.params)
          end
        end
      end
    end
  end
end