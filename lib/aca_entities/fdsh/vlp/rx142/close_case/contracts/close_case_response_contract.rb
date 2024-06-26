# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx142
        module CloseCase
          module Contracts
            # FDSH schema and validation rules for {AcaEntities::Fdsh::Person::PersonName}
            class CloseCaseResponseContract < Dry::Validation::Contract

              params do
                required(:ResponseMetadata).filled(Fdsh::Vlp::Rx142::CloseCase::Contracts::ResponseMetadataContract.params)

                optional(:ArrayOfErrorResponseMetadata).array(Fdsh::Vlp::Rx142::CloseCase::Contracts::ErrorResponseMetadataContract.params)
                optional(:CloseCaseResponseSet).maybe(Fdsh::Vlp::Rx142::CloseCase::Contracts::CloseCaseResponseSetContract.params)
              end
            end
          end
        end
      end
    end
  end
end