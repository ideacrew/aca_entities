# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an TransmissionMetadata.
          class ReportPeriod
            include HappyMapper
            register_namespace 'ns3', 'http://niem.gov/niem/niem-core/2.0'
            register_namespace 'ns4', "http://birsrep.dsh.cms.gov/extension/1.0"

            tag 'ReportPeriod'
            namespace 'ns4'

            element :YearMonth, String, tag: 'YearMonth', namespace: 'ns3'

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.YearMonth = request.YearMonth if request.YearMonth.present?

              mapper
            end
          end
        end
      end
    end
  end
end