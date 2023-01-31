# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H41
          # Happymapper implementation for the root object of an Request.
          class UsAddressGroup
            include HappyMapper
            register_namespace 'airty20a', "urn:us:gov:treasury:irs:ext:aca:air:ty20a"
            register_namespace 'irs', 'urn:us:gov:treasury:irs:common'

            tag 'USAddressGrp'
            namespace 'airty20a'

            element :AddressLine1Txt, String, tag: 'AddressLine1Txt'
            element :AddressLine2Txt, String, tag: 'AddressLine2Txt'
            element :CityNm, String, tag: 'CityNm', namespace: "irs"
            element :USStateCd, String, tag: 'USStateCd'
            element :USZIPCd, String, tag: 'USZIPCd', namespace: "irs"

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.AddressLine1Txt = request.AddressLine1Txt
              mapper.AddressLine2Txt = request.AddressLine2Txt if request.AddressLine2Txt
              mapper.CityNm = request.CityNm
              mapper.USStateCd = request.USStateCd
              mapper.USZIPCd = request.USZIPCd

              mapper
            end
          end
        end
      end
    end
  end
end
