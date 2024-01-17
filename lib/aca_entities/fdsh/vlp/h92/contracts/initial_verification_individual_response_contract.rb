# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp InitialVerificationIndividualResponse
        class InitialVerificationIndividualResponseContract < Dry::Validation::Contract
          params do
            required(:ResponseMetadata).filled(Fdsh::Vlp::H92::ResponseMetadataContract.params)
            required(:LawfulPresenceVerifiedCode).filled(:string)
            optional(:InitialVerificationIndividualResponseSet).maybe(Fdsh::Vlp::H92::InitialVerificationIndividualResponseSetContract.params)
            optional(:ArrayOfErrorResponseMetadata).array(Fdsh::Vlp::H92::ErrorResponseMetadataContract.params)
          end
        end
      end
    end
  end
end