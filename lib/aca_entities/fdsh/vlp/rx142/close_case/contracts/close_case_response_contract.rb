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

                optional(:ArrayOfErrorResponseMetadata).filled(Fdsh::Vlp::Rx142::CloseCase::Contracts::ArrayOfErrorResponseMetadataContract.params)
                optional(:CloseCaseResponseSet).filled(Fdsh::Vlp::Rx142::CloseCase::Contracts::CloseCaseResponseSetContract.params)
              end
            end
          end
        end
      end
    end
  end
end