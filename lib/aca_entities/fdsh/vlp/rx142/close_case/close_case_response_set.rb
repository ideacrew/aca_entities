# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx142
        module CloseCase
          # Entity for Fdsh Vlp CloseCaseResponseSet
          class CloseCaseResponseSet < Dry::Struct
            attribute :WebServSftwrVer, Types::Strict::String.meta(omittable: false)
          end
        end
      end
    end
  end
end
