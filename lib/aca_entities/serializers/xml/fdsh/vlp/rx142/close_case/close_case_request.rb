# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module Rx142
            module CloseCase
              # Happymapper implementation for the root object of an
              # Request.
              class CloseCaseRequest
                include HappyMapper
                register_namespace 'vlpcc', 'http://vclpcc.ee.sim.dsh.cms.hhs.gov'

                tag 'CloseCaseRequest'
                namespace 'vlpcc'

                element :CaseNumber, String, tag: 'CaseNumber', namespace: 'vlpcc'

                def self.domain_to_mapper(document)
                  mapper = self.new
                  mapper.CaseNumber = document.CaseNumber

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
