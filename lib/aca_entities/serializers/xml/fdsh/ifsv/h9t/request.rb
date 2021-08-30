# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ifsv
          module H9t
            # Happymapper implementation for the root object of an Request.
            class Request
              include HappyMapper
              register_namespace 'exch', 'http://ifsv.dsh.cms.gov/exchange/1.0'
              register_namespace 'hcore', 'http://hix.cms.gov/0.1/hix-core'

              tag 'IFSVRequest'
              namespace 'exch'

              element :RequestID, String, tag: 'RequestID', namespace: "hcore"
              has_many :IFSVApplicants, IFSVApplicant

              def self.domain_to_mapper(request)
                mapper = self.new
                mapper.RequestID = request.RequestID
                mapper.IFSVApplicants = request.IFSVApplicants.collect do |applicant_request|
                  IFSVApplicant.domain_to_mapper(applicant_request)
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