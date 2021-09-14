# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module Ifsv
            # Happymapper implementation for the root object of an Response.
            class VerifyHouseholdIncomeAndFamilySizeBulkResponse
              include HappyMapper
              register_namespace 'irs', 'urn:us:gov:treasury:irs:common'

              tag 'VerifyHsldIncmAndFamSzBulkRspns'

              has_many :IFSVApplicantResponseGrps, IfsvApplicantResponseGroup
              has_one :ErrorMessageDetail, ErrorMessageDetail

              def self.domain_to_mapper(response)
                mapper = self.new
                mapper.IFSVApplicantResponseGrps = request.IFSVApplicantResponseGrps.collect do |response_group|
                  IfsvApplicantResponseGroup.domain_to_mapper(response_group)
                end
                mapper.ErrorMessageDetail = ErrorMessageDetail.domain_to_mapper(response.ErrorMessageDetail)

                mapper
              end
            end
          end
        end
      end
    end
  end
end
