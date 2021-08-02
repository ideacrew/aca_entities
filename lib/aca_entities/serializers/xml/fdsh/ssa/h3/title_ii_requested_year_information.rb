# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # response.
            class TitleIIRequestedYearInformation
              include HappyMapper
              register_namespace 'extn', 'http://extn.ssac.ee.sim.dsh.cms.hhs.gov'

              tag 'TitleIIRequestedYearInformation'
              namespace 'extn'

              attribute :IncomeDate, String, tag: 'IncomeDate', namespace: "extn"
              attribute :YearlyIncomeAmount, BigDecimal, tag: 'YearlyIncomeAmount', namespace: "extn"

              def self.domain_to_mapper(initial_response)
                mapper = self.new
                mapper.IncomeDate = initial_response.IncomeDate
                mapper.YearlyIncomeAmount = initial_response.YearlyIncomeAmount

                mapper
              end
            end
          end
        end
      end
    end
  end
end