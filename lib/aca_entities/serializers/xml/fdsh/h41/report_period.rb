# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H41
          # Happymapper implementation for the root object of an TransmissionMetadata.
          class ReportPeriod
            include HappyMapper
            register_namespace 'ns4', "http://birsrep.dsh.cms.gov/extension/1.0"
            register_namespace 'ns5', "http://niem.gov/niem/niem-core/2.0"

            tag 'ReportPeriod'
            namespace 'ns4'

            element :Year, String, tag: 'Year', namespace: 'ns5'

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.Year = request.Year if request.Year.present?

              mapper
            end
          end
        end
      end
    end
  end
end