# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx142
        module CloseCase
          # Entity for Fdsh Vlp CloseCaseResponse
          class CloseCaseResponse < Dry::Struct
            attribute :ResponseMetadata,                Fdsh::Vlp::Rx142::CloseCase::ResponseMetadata.meta(omittable: false)
            attribute :ArrayOfErrorResponseMetadata,    Fdsh::Vlp::Rx142::CloseCase::ArrayOfErrorResponseMetadata.optional.meta(omittable: false)
            attribute :CloseCaseResponseSet,            Fdsh::Vlp::Rx142::CloseCase::CloseCaseResponseSet.optional.meta(omittable: false)
          end
        end
      end
    end
  end
end