# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An identification assigned by a Children’s Health Insurance Program (CHIP) program to an individual.
          class PersonChipIdentification
            include HappyMapper

            tag 'PersonCHIPIdentification'
            namespace 'hix-core'

            element :identification_id, String, tag: 'IdentificationID', namespace:'nc'

            def self.domain_to_mapper(id)
              mapper = self.new
              mapper
            end

            def to_hash
              {
                identification_id: identification_id
              }
            end
          end
        end
      end
    end
  end
end