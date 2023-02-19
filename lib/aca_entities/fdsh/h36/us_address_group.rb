# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for h41 UsAddressGroup
      class UsAddressGroup < Dry::Struct
        attribute :AddressLine1Txt,  AcaEntities::Types::String.meta(omittable: false)
        attribute :AddressLine2Txt, AcaEntities::Types::String.optional.meta(omittable: true)
        attribute :CityNm,  AcaEntities::Types::String.meta(omittable: false)
        attribute :USStateCd,  AcaEntities::Types::String.meta(omittable: false)
        attribute :USZIPCd,  AcaEntities::Types::String.meta(omittable: false)
        attribute :USZIPExtensionCd, AcaEntities::Types::String.optional.meta(omittable: true)
      end
    end
  end
end
