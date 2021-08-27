# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Esi
          module H14
            # Happymapper implementation for the root object of an Request.
            class EsiMecRequest
              include HappyMapper
              register_namespace 'exch', 'http://vesim.dsh.cms.gov/exchange/1.0'

              tag 'ESIMECRequest'
              namespace 'exch'

              has_many :ApplicantRequests, ApplicantRequest

              def self.domain_to_mapper(request)
                mapper = self.new
                mapper.ApplicantRequests = request.ApplicantRequests.collect do |applicant_request|
                  ApplicantRequest.domain_to_mapper(applicant_request)
                end
                mapper
              end
            end
          end
        end
      end
    end
  end
end
