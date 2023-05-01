# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      # Entity for H41 TransmissionMetadata
      class TransmissionMetadata < Dry::Struct
        attribute :TransmissionAttachmentQuantity,   AcaEntities::Types::Integer.meta(omittable: false)
        attribute :TransmissionSequenceID,  AcaEntities::Types::Integer.meta(omittable: false)
      end
    end
  end
end