# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # response.
            class QualifyingYearAndQuarter
              include HappyMapper
              register_namespace 'extn', 'http://extn.ssac.ee.sim.dsh.cms.hhs.gov'

              tag 'QualifyingYearAndQuarter'
              namespace 'extn'

              element :QualifyingYear, String, tag: 'QualifyingYear', namespace: "extn"
              element :QualifyingQuarter, Integer, tag: 'QualifyingQuarter', namespace: "extn"

              def self.domain_to_mapper(initial_response)
                mapper = self.new
                mapper.QualifyingYear = initial_response.QualifyingYear
                mapper.QualifyingQuarter = initial_response.QualifyingQuarter

                mapper
              end
            end
          end
        end
      end
    end
  end
end