# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Medicare
        # Entity for Medicare EesdshbatchRequest
        class EesDshBatchRequestData < Dry::Struct
          attribute :IndividualRequests,  Types::Array.of(Fdsh::Rrv::Medicare::IndividualRequest).meta(omittable: false)
        end
      end
    end
  end
end