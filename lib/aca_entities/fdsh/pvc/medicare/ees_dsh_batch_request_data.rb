# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Medicare
        # Entity for Medicare EesdshbatchRequest
        class EesDshBatchRequestData < Dry::Struct
          attribute :IndividualRequests,  Types::Array.of(Fdsh::Pvc::Medicare::IndividualRequest).meta(omittable: false)
        end
      end
    end
  end
end