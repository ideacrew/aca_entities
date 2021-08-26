# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp InitialVerificationResponse
        class InitialVerificationResponseContract < Dry::Validation::Contract

          params do
            required(:ResponseMetadata).filled(Fdsh::Vlp::H92::ResponseMetadataContract.params)
            required(:InitialVerificationResponseSet).filled(Fdsh::Vlp::H92::InitialVerificationResponseSetContract.params)
          end
        end
      end
    end
  end
end