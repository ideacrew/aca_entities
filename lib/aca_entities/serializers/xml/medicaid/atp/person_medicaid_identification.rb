# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An identification assigned by a Medicaid program to an individual.
          class PersonMedicaidIdentification
            include HappyMapper

            tag 'PersonMedicaidIdentification'
            namespace 'hix-core'

            element :identification_id, String, tag: 'IdentificationID', namespace: 'nc'

            def self.domain_to_mapper(medicaid_id)
              mapper = self.new
              mapper.identification_id = medicaid_id.identification_id
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