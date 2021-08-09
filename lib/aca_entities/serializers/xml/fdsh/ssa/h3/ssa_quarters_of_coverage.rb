# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # response.
            class SSAQuartersOfCoverage
              include HappyMapper
              register_namespace 'extn', 'http://extn.ssac.ee.sim.dsh.cms.hhs.gov'

              tag 'SSAQuartersOfCoverage'
              namespace 'extn'

              element :LifeTimeQuarterQuantity, Integer, tag: 'LifeTimeQuarterQuantity', namespace: "extn"
              has_one :QualifyingYearAndQuarter, QualifyingYearAndQuarter

              def self.domain_to_mapper(initial_response)
                mapper = self.new
                mapper.LifeTimeQuarterQuantity = initial_response.LifeTimeQuarterQuantity
                mapper.QualifyingYearAndQuarter = QualifyingYearAndQuarter.domain_to_mapper(initial_response.QualifyingYearAndQuarter)

                mapper
              end
            end
          end
        end
      end
    end
  end
end