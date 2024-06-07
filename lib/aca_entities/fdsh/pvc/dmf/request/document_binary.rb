# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Request
        # Entity for PVC DocumentBinary
        class DocumentBinary < Dry::Struct
          attribute :ChecksumAugmentation do
            attribute :SHA256HashValueText, AcaEntities::Types::String.meta(omittable: false)
          end
          attribute :BinarySizeValue, Types::Integer.meta(omittable: false)
        end
      end
    end
    end
  end
end
