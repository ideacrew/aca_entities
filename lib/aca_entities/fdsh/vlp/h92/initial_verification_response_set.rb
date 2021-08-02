# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp InitialVerificationResponseSet
        class InitialVerificationResponseSet < Dry::Struct

          attribute :InitialVerificationIndividualResponses,
                    Types::Array.of(Fdsh::Vlp::H92::InitialVerificationIndividualResponse).meta(omittable: false)
        end
      end
    end
  end
end