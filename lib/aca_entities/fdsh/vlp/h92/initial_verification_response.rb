# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp InitialVerificationResponse
        class InitialVerificationResponse < Dry::Struct

          attribute :ResponseMetadata,  Fdsh::Vlp::H92::ResponseMetadata.meta(omittable: false)
          attribute :InitialVerificationResponseSet,  Fdsh::Vlp::H92::InitialVerificationResponseSet.meta(omittable: false)
        end
      end
    end
  end
end