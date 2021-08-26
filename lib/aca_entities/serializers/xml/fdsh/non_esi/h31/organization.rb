# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module NonEsi
          module H31
            # Happymapper implementation for the root object of an Request.
            class Organization
              include HappyMapper
              register_namespace 'vnem', 'http://vnem.ee.sim.dsh.cms.hhs.gov'

              tag 'Organization'
              namespace 'vnem'

              has_many :OrganizationCodes, String, tag: 'OrganizationCode', namespace: 'vnem'

              def self.domain_to_mapper(organization)
                mapper = self.new
                mapper.OrganizationCodes = organization.OrganizationCodes

                mapper
              end
            end
          end
        end
      end
    end
  end
end