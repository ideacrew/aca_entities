# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Response
              module Record
                # Happymapper implementation for the root object of an Request.
                #
                # @!attribute [rw] SSNIdentification
                #   @return [String] The SSN Identification of the person.
                class PersonSSNIdentification
                  include HappyMapper
                  register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

                  tag 'PersonSSNIdentification'
                  namespace 'nc'

                  element :ssn_identification, String, tag: 'SSNIdentification', namespace: 'ext'

                  # Maps domain SSN identification to mapper
                  #
                  # @param person_ssn [Object] the person's SSN identification from the domain
                  #
                  # @return [PersonSSNIdentification] the mapped person SSN identification
                  def self.domain_to_mapper(person_ssn)
                    mapper = self.new
                    mapper.SSNIdentification = person_ssn.SSNIdentification

                    mapper
                  end

                  # convert domain to hash
                  def to_hash
                    {
                      SSNIdentification: ssn_identification
                    }
                  end

                end
              end
            end
          end
        end
      end
    end
  end
end

