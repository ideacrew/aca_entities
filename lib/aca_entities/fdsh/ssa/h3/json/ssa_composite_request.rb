# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        module Json
          # Entity for Fdsh JSON ssaCompositeRequest Request
          class SsaCompositeRequest < Dry::Struct

            attribute :ssaCompositeIndividualRequestArray,
                      Types::Array.of(Fdsh::Ssa::H3::Json::SsaCompositeIndividualRequestArray).meta(omittable: false)
          end
        end
      end
    end
  end
end