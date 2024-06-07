# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Request
          # Entity for IndividualRequest
          class IndividualRequests < Dry::Struct

            attribute :IndividualRequests,   Types::Array.of(AcaEntities::Fdsh::Pvc::Dmf::Request::IndividualRequest).meta(omittable: false)
          end
        end
      end
    end
  end
end