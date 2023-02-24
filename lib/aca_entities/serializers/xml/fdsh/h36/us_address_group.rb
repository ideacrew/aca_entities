# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an UsAddressGroup.
          class UsAddressGroup
            include HappyMapper

            tag 'USAddressGrp'

            element :AddressLine1Txt, String, tag: "AddressLine1Txt"
            element :AddressLine2Txt, String, tag: "AddressLine2Txt"
            element :CityNm, String, tag: "CityNm"
            element :USStateCd, String, tag: "USStateCd"
            element :USZIPCd, String, tag: "USZIPCd"
            element :USZIPExtensionCd, String, tag: "USZIPExtensionCd"

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.AddressLine1Txt = request.AddressLine1Txt
              mapper.AddressLine2Txt = request.AddressLine2Txt if request.AddressLine2Txt
              mapper.CityNm = request.CityNm
              mapper.USStateCd = request.USStateCd
              mapper.USZIPCd = request.USZIPCd
              mapper.USZIPExtensionCd = request.USZIPExtensionCd if request.USZIPExtensionCd

              mapper
            end
          end
        end
      end
    end
  end
end