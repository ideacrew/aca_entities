# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an Primary.
          class Primary
            include HappyMapper

            tag 'Primary'

            has_one :CompletePersonName, CompletePersonName
            element :SSN, String, tag: "SSN"
            element :BirthDt, String, tag: "BirthDt"
            has_one :PersonAddressGroup, PersonAddressGroup

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.CompletePersonName = CompletePersonName.domain_to_mapper(request.CompletePersonName)
              mapper.SSN = request.SSN if request.SSN
              mapper.BirthDt = request.BirthDt if request.BirthDt
              mapper.PersonAddressGroup = PersonAddressGroup.domain_to_mapper(request.PersonAddressGroup)

              mapper
            end
          end
        end
      end
    end
  end
end