# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H41
          # Happymapper implementation for the root object of an TransmissionMetadata.
          class ServiceSpecificData
            include HappyMapper
            register_namespace 'ns4', "http://birsrep.dsh.cms.gov/extension/1.0"

            tag 'ServiceSpecificData'
            namespace 'ns4'

            has_one :ReportPeriod, ReportPeriod

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.ReportPeriod = ReportPeriod.domain_to_mapper(request.ReportPeriod) if request.ReportPeriod.present?

              mapper
            end
          end
        end
      end
    end
  end
end