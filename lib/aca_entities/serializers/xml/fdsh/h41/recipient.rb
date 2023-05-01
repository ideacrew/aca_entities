# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H41
          # Happymapper implementation for the root object of an Request.
          class Recipient
            include HappyMapper
            register_namespace 'airty20a', "urn:us:gov:treasury:irs:ext:aca:air:ty20a"
            register_namespace 'irs', 'urn:us:gov:treasury:irs:common'

            tag 'Recipient'
            namespace 'airty20a'

            has_one :OtherCompletePersonName, OtherCompletePersonName
            element :SSN, String, tag: 'SSN', namespace: "irs"
            element :BirthDt, String, tag: 'BirthDt'
            has_one :USAddressGroup, UsAddressGroup

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.OtherCompletePersonName = OtherCompletePersonName.domain_to_mapper(request.OtherCompletePersonName)
              mapper.USAddressGroup = UsAddressGroup.domain_to_mapper(request.UsAddressGroup)
              mapper.SSN = request.SSN if request.SSN
              mapper.BirthDt = request.BirthDt if request.BirthDt

              mapper
            end
          end
        end
      end
    end
  end
end
