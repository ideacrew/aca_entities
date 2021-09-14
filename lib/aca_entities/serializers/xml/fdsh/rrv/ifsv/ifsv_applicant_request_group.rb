# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module Ifsv
            # Happymapper implementation for the root object of an Request.
            class IfsvApplicantRequestGroup
              include HappyMapper
              register_namespace 'irs', 'urn:us:gov:treasury:irs:common'

              tag 'IFSVApplicantRequestGrp'

              element :RequestId, String, tag: 'RequestId', namespace: "irs"
              has_many :IFSVApplicants, IfsvApplicant

              def self.domain_to_mapper(request_group)
                mapper = self.new
                mapper.RequestId = request_group.RequestId
                mapper.IFSVApplicants = request_group.IFSVApplicants.collect do |applicant|
                  IfsvApplicant.domain_to_mapper(applicant)
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
