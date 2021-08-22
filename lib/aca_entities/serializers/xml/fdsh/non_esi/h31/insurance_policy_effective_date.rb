# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module NonEsi
          module H31
            # Include XML element and type definitions.
            class InsurancePolicyEffectiveDate
              include HappyMapper
              register_namespace 'vnem', 'http://vnem.ee.sim.dsh.cms.hhs.gov'

              tag 'InsurancePolicyEffectiveDate'
              namespace 'vnem'

              element :date, Date, tag: "Date", namespace: "vnem"

              def self.domain_to_mapper(start_date)
                mapper = self.new
                mapper.date = start_date.strftime

                mapper
              end
            end
          end
        end
      end
    end
  end
end
