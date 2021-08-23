# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Contract for FDSH ESI Verification contract
        class ApplicantResponseContract < Dry::Validation::Contract
          params do
            required(:ResponsePerson).filled(AcaEntities::Fdsh::Esi::H14::ResponsePersonContract.params)
            required(:ResponseMetadata).filled(AcaEntities::Fdsh::Esi::H14::ResponseMetadataContract.params)
            optional(:ApplicantMECInformation).maybe(AcaEntities::Fdsh::Esi::H14::ApplicantMECInformationContract.params)
          end
        end
      end
    end
  end
end