# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx1424
        # Entity for Fdsh Vlp CloseCaseResponseSet
        class CloseCaseResponseSet < Dry::Struct
          attribute :WebServSftwrVer, Types::Strict::String.meta(omittable: false)
        end
      end
    end
  end
end
