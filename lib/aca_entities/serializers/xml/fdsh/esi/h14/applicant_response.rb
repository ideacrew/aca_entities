# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Esi
          module H14
            # Happymapper implementation for the root object of an applicant response.
            class ApplicantResponse
              include HappyMapper
              register_namespace 'ext', 'http://vesim.dsh.cms.gov/extension/1.0'

              tag 'ApplicantResponse'
              namespace 'ext'

              has_one :ResponsePerson, ResponsePerson
              has_one :ResponseMetadata, ResponseMetadata
              has_one :ApplicantMECInformation, ApplicantMecInformation

              def self.domain_to_mapper(response)
                mapper = self.new
                mapper.ResponsePerson = ResponsePerson.domain_to_mapper(response.ResponsePerson)
                mapper.ResponseMetadata = ResponseMetadata.domain_to_mapper(response.ResponseMetadata)
                mapper.ApplicantMECInformation = ApplicantMecInformation.domain_to_mapper(response.ApplicantMECInformation)

                mapper
              end
            end
          end
        end
      end
    end
  end
end
