# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx142
        module CloseCase
          # Entity for Fdsh Vlp CloseCaseResponse
          class CloseCaseResponse < Dry::Struct
            attribute :ResponseMetadata,                Fdsh::Vlp::Rx142::CloseCase::ResponseMetadata.meta(omittable: false)
            # rubocop:disable Layout/LineLength
            attribute :ArrayOfErrorResponseMetadata,    Types::Array.of(Fdsh::Vlp::Rx142::CloseCase::ErrorResponseMetadata).optional.meta(omittable: true)
            # rubocop:enable Layout/LineLength
            attribute :CloseCaseResponseSet,            Fdsh::Vlp::Rx142::CloseCase::CloseCaseResponseSet.optional.meta(omittable: true)
          end
        end
      end
    end
  end
end