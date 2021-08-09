# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Contract for Ssa Verification contract
        class SSACompositeIndividualResponseContract < Dry::Validation::Contract

          params do
            required(:ResponseMetadata).filled(AcaEntities::Fdsh::Ssa::H3::ResponseMetadataContract.params)
            required(:PersonSSNIdentification).filled(:string)
            optional(:SSAResponse).maybe(AcaEntities::Fdsh::Ssa::H3::SSAResponseContract.params)
          end
        end
      end
    end
  end
end