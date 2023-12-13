# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx1424
        # Entity for Fdsh Vlp CloseCaseRequest
        class CloseCaseRequest < Dry::Struct
          attribute :CaseNumber,  Types::Strict::String.meta(omittable: false)
        end
      end
    end
  end
end