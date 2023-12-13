# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module Rx1424
            # Happymapper implementation for the root object of an
            # response.
            class CloseCaseResponseSet
              include HappyMapper
              register_namespace 'vlpcc', 'http://vclpcc.ee.sim.dsh.cms.hhs.gov'

              tag 'CloseCaseResponseSet'
              namespace 'vlpcc'

              element :WebServSftwrVerType, String, tag: "WebServSftwrVerType"

              def self.domain_to_mapper(response_set)
                mapper = self.new
                mapper.WebServSftwrVerType = response_set.WebServSftwrVerType

                mapper
              end
            end
          end
        end
      end
    end
  end
end