# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Entity for RRV TransmissionMetadata
        class TransmissionMetadata < Dry::Struct
          attribute :TransmissionAttachmentQuantity,   AcaEntities::Types::Decimal.meta(omittable: false)
          attribute :TransmissionSequenceID,  AcaEntities::Types::Integer.meta(omittable: false)
        end
      end
    end
  end
end