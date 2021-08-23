# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Esi
          module H14
            # Happymapper implementation for the root object of an Request.
            class ApplicantRequest
              include HappyMapper
              register_namespace 'ext', 'http://vesim.dsh.cms.gov/extension/1.0'

              tag 'ApplicantRequest'
              namespace 'ext'

              has_one :RequestPerson, RequestPerson
              has_one :InsuranceApplicantRequest, InsuranceApplicantRequest
              element :PersonLocationState, String, tag: 'PersonLocationState', namespace: "ext"

              def self.domain_to_mapper(request)
                mapper = self.new
                mapper.RequestPerson = RequestPerson.domain_to_mapper(request.RequestPerson)
                mapper.InsuranceApplicantRequest = InsuranceApplicantRequest.domain_to_mapper(request.InsuranceApplicantRequest)
                mapper.PersonLocationState = request.PersonLocationState

                mapper
              end
            end
          end
        end
      end
    end
  end
end
