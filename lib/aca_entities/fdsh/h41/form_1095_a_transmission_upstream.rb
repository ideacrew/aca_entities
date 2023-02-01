# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      # Entity for h41 contract Form1095ATransmissionUpstream
      class Form1095ATransmissionUpstream < Dry::Struct
        attribute :Form1095AUpstreamDetail, Types::Array.of(AcaEntities::Fdsh::H41::Form1095aUpstreamDetail).meta(omittable: false)
      end
    end
  end
end
