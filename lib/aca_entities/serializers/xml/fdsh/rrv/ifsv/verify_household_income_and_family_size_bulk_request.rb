# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module Ifsv
            # Happymapper implementation for the root object of an Request.
            class VerifyHouseholdIncomeAndFamilySizeBulkRequest
              include HappyMapper
              register_namespace 'xmlns', 'urn:us:gov:treasury:irs:msg:hhsirsverifyhouseholdincomeandfamilysize'

              tag 'VerifyHsldIncmAndFamSizeBulkReq'

              has_many :IFSVApplicantRequestGrps, IfsvApplicantRequestGroup

              def self.domain_to_mapper(request)
                mapper = self.new
                mapper.IFSVApplicantRequestGrps = request.IFSVApplicantRequestGrps.collect do |request_group|
                  IfsvApplicantRequestGroup.domain_to_mapper(request_group)
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
