# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx1424
        module Contracts
          # FDSH schema and validation rules for {AcaEntities::Fdsh::Person::PersonName}
          class CloseCaseResponseContract < Dry::Validation::Contract

            params do
              required(:ResponseMetadata).filled(Fdsh::Vlp::Rx1424::Contracts::ResponseMetadataContract.params)

              optional(:ArrayOfErrorResponseMetadata).filled(Fdsh::Vlp::Rx1424::Contracts::ArrayOfErrorResponseMetadataContract.params)
              optional(:CloseCaseResponseSet).filled(Fdsh::Vlp::Rx1424::Contracts::CloseCaseResponseSetContract.params)
            end
          end
        end
      end
    end
  end
end