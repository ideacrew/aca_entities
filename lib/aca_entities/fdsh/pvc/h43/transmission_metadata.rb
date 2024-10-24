# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module H43
        # Entity for PVC TransmissionMetadata
        class TransmissionMetadata < Dry::Struct
          attribute :TransmissionAttachmentQuantity,   Types::Integer.meta(omittable: false)
          attribute :TransmissionSequenceID,  AcaEntities::Types::Integer.meta(omittable: false)
        end
      end
    end
  end
end