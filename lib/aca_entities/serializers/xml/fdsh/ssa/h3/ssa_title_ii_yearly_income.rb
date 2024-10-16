# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # response.
            class SSATitleIIYearlyIncome
              include HappyMapper
              register_namespace 'extn', 'http://extn.ssac.ee.sim.dsh.cms.hhs.gov'

              tag 'SSATitleIIYearlyIncome'
              namespace 'extn'

              has_one :TitleIIRequestedYearInformation, TitleIIRequestedYearInformation

              def self.domain_to_mapper(initial_response)
                mapper = self.new
                mapper.TitleIIRequestedYearInformation =
                  TitleIIRequestedYearInformation.domain_to_mapper(initial_response.TitleIIRequestedYearInformation)

                mapper
              end
            end
          end
        end
      end
    end
  end
end