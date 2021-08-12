# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        module Contracts
          # Contract for FDSH ESI Verification contract
          class ApplicantResponseContract < Dry::Validation::Contract
            params do
              required(:ResponsePerson).filled(AcaEntities::Fdsh::Esi::H14::Contracts::ResponsePersonContract.params)
              required(:ResponseMetadata).filled(AcaEntities::Fdsh::Esi::H14::Contracts::ResponseMetadataContract.params)
              optional(:ApplicantMECInformation).maybe(AcaEntities::Fdsh::Esi::H14::Contracts::ApplicantMECInformationContract.params)
            end
          end
        end
      end
    end
  end
end