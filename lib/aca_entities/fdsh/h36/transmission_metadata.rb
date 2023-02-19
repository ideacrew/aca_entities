# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for H36 TransmissionMetadata
      class TransmissionMetadata < Dry::Struct
        attribute :TransmissionAttachmentQuantity,   AcaEntities::Types::Integer.meta(omittable: false)
        attribute :TransmissionSequenceID,  AcaEntities::Types::Integer.meta(omittable: false)
      end
    end
  end
end
