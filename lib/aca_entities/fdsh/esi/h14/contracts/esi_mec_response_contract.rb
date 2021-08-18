# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Contract for FDSH ESI Verification contract
        class ESIMECResponseContract < Dry::Validation::Contract
          params do
            optional(:ApplicantResponseSet).maybe(AcaEntities::Fdsh::Esi::H14::ApplicantResponseSetContract.params)
            optional(:ResponseMetadata).maybe(AcaEntities::Fdsh::Esi::H14::ResponseMetadataContract.params)
          end
        end
      end
    end
  end
end