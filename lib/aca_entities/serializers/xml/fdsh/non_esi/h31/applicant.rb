# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module NonEsi
          module H31
            # Happymapper implementation for the root object of an Request.
            class Applicant
              include HappyMapper
              register_namespace 'vnem', 'http://vnem.ee.sim.dsh.cms.hhs.gov'
              register_namespace 'ns1', 'http://niem.gov/niem/niem-core/2.0'

              tag 'Applicant'
              namespace 'vnem'

              element :PersonSSNIdentification, String, tag: 'PersonSSNIdentification', namespace: 'vnem'
              has_one :PersonName, PersonName
              has_one :PersonBirthDate, PersonBirthDate
              element :PersonSexCode, String, tag: 'PersonSexCode', namespace: 'ns1'

              def self.domain_to_mapper(applicant)
                mapper = self.new
                mapper.PersonSSNIdentification = applicant.PersonSSNIdentification
                mapper.PersonName = PersonName.domain_to_mapper(applicant.PersonName)
                mapper.PersonBirthDate = PersonBirthDate.domain_to_mapper(applicant.PersonBirthDate)
                mapper.PersonSexCode = applicant.PersonSexCode

                mapper
              end
            end
          end
        end
      end
    end
  end
end
