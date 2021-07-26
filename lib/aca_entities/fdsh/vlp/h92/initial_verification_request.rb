# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp InitialVerificationRequest
        class InitialVerificationRequest < Dry::Struct

          attribute :InitialVerificationRequestSet,  Types::Array.of(Fdsh::Vlp::H92::InitialVerificationRequestSet).meta(omittable: false)
        end
      end
    end
  end
end