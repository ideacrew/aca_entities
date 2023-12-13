# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx1424
        # Entity for Fdsh Vlp CloseCaseResponse
        class CloseCaseResponse < Dry::Struct
          attribute :ResponseMetadata,                Fdsh::Vlp::Rx1424::ResponseMetadata.meta(omittable: false)
          attribute :ArrayOfErrorResponseMetadata,    Fdsh::Vlp::Rx1424::ArrayOfErrorResponseMetadata.optional.meta(omittable: false)
          attribute :CloseCaseResponseSet,            Fdsh::Vlp::Rx1424::CloseCaseResponseSet.optional.meta(omittable: false)
        end
      end
    end
  end
end