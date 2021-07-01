# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for Request
        class Request < Dry::Struct

          attribute :PrimaryRequest,    AcaEntities::Fdsh::Ridp::H139::PrimaryRequest.optional.meta(omittable: true)
          attribute :SecondaryRequest,  AcaEntities::Fdsh::Ridp::H139::SecondaryRequest.optional.meta(omittable: true)

        end
      end
    end
  end
end
