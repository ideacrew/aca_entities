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
            required(:InitialVerificationIndividualResponseSet).filled(Fdsh::Vlp::H92::InitialVerificationIndividualResponseSetContract.params)
            optional(:ArrayOfErrorResponseMetadata).maybe(Fdsh::Vlp::H92::ArrayOfErrorResponseMetadataContract.params)
          end
        end
      end
    end
  end
end