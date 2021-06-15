# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An identification assigned by a Medicaid program to an individual.
          class PersonMedicaidIdentification
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'PersonMedicaidIdentification'
            namespace 'hix-core'

            element :identification_id, String, tag: 'IdentificationID', namespace:'nc'

            def self.domain_to_mapper(id)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end