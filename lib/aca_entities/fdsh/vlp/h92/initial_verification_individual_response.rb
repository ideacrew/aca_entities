# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp InitialVerificationIndividualResponse
        class InitialVerificationIndividualResponse < Dry::Struct

          attribute :ResponseMetadata, Fdsh::Vlp::H92::ResponseMetadata.meta(omittable: false)
          attribute :ArrayOfErrorResponseMetadata,    Types::Array.of(Fdsh::Vlp::H92::ErrorResponseMetadata).optional.meta(omittable: true)
          attribute :LawfulPresenceVerifiedCode, Types::Strict::String.meta(omittable: false)
          attribute :InitialVerificationIndividualResponseSet, Fdsh::Vlp::H92::InitialVerificationIndividualResponseSet.meta(omittable: false)
        end
      end
    end
  end
end