# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module NonEsi
          module H31
            # Happymapper implementation for the root object of an Individual response.
            class OtherCoverage
              include HappyMapper
              register_namespace 'vnem', 'http://vnem.ee.sim.dsh.cms.hhs.gov'

              tag 'OtherCoverage'
              namespace 'vnem'

              element :OrganizationCode, String, tag: 'OrganizationCode', namespace: 'vnem'
              has_one :ResponseMetadata, ResponseMetadata, tag: 'ResponseMetadata', namespace: 'vnem'
              has_one :MECCoverage, MecCoverage

              def self.domain_to_mapper(other_coverage)
                mapper = self.new
                mapper.OrganizationCode = other_coverage.OrganizationCode
                mapper.ResponseMetadata = ResponseMetadata.domain_to_mapper(other_coverage.ResponseMetadata)
                mapper.MECCoverage = MecCoverage.domain_to_mapper(other_coverage.MECCoverage)

                mapper
              end
            end
          end
        end
      end
    end
  end
end
