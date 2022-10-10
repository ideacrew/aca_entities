# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Medicare
        # Entity for Medicare EesDshBatchResponseData
        class EesDshBatchResponseData < Dry::Struct
          attribute :IndividualResponses,  Types::Array.of(Fdsh::Pvc::Medicare::IndividualResponse).meta(omittable: false)
        end
      end
    end
  end
end