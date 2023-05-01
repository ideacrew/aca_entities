# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      # Entity for H41 Attachment
      class Attachment < Dry::Struct
        attribute :DocumentBinary,  AcaEntities::Fdsh::H41::DocumentBinary.optional.meta(omittable: true)
        attribute :DocumentFileName,  AcaEntities::Types::String.meta(omittable: false)
        attribute :DocumentSequenceID,  AcaEntities::Types::String.meta(omittable: false)
      end
    end
  end
end
