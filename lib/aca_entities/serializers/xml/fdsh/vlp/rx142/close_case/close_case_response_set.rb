# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module Rx142
            module CloseCase
              # Happymapper implementation for the root object of an
              # response.
              class CloseCaseResponseSet
                include HappyMapper
                register_namespace 'vlpcc', 'http://vclpcc.ee.sim.dsh.cms.hhs.gov'

                tag 'CloseCaseResponseSet'
                namespace 'vlpcc'

                element :WebServSftwrVer, String, tag: "WebServSftwrVer"

                def self.domain_to_mapper(response_set)
                  mapper = self.new
                  mapper.WebServSftwrVer = response_set.WebServSftwrVer

                  mapper
                end
              end
            end
          end
        end
      end
    end
  end
end