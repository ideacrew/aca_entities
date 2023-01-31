# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H41
          # Happymapper implementation for the root object of an Request.
          class InsuredPerson
            include HappyMapper
            register_namespace 'airty20a', 'urn:us:gov:treasury:irs:ext:aca:air:ty20a'
            register_namespace 'irs', 'urn:us:gov:treasury:irs:common'

            tag 'InsuredPerson'
            namespace 'airty20a'

            has_one :OtherCompletePersonName, OtherCompletePersonName
            element :SSN, String, tag: 'SSN', namespace: "irs"
            element :BirthDt, String, tag: 'BirthDt', namespace: "airty20a"

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.OtherCompletePersonName = OtherCompletePersonName.domain_to_mapper(request.OtherCompletePersonName)
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
